import requests
from bs4 import BeautifulSoup
import json
import re
from datetime import datetime
import sys

def parse_entry(entry_text):
    # Regex to capture number, date, and name
    # The name is non-greedy and stops at the next entry start
    match = re.match(r'(#\d+|暫定|（[^）]+）)\s+([\d\.\?]+)\s+(.*?)(?=\s*#\d+|\s*暫定|\s*（|$)', entry_text, re.DOTALL)
    if match:
        num_text, date_text, name_text = match.groups()

        num = None
        if num_text.startswith('#'):
            try:
                num = int(num_text[1:])
            except (ValueError, TypeError):
                num = num_text
        else:
            num = num_text

        date_iso = None
        if date_text:
            try:
                date_str_formatted = date_text.replace('.', '/').replace('?', '1')
                if '??' in date_str_formatted:
                    date_iso = None
                else:
                    if '/??' in date_str_formatted:
                        date_str_formatted = date_str_formatted.replace('/??', '/01')
                    if date_str_formatted.endswith('/'):
                        date_str_formatted += '01'
                    date_obj = datetime.strptime(date_str_formatted, '%Y/%m/%d')
                    date_iso = date_obj.strftime('%Y-%m-%d')
            except ValueError:
                date_iso = None

        # Clean up name text
        name_text = name_text.strip()
        # Remove the bracketed notes from the end of the name
        name_text = re.sub(r'\[\d+\]$', '', name_text).strip()

        return {
            "number": num,
            "date": date_iso,
            "name": name_text
        }
    return None

def scrape_winners():
    url = "https://extremeparty.heteml.net/title.html"
    try:
        response = requests.get(url)
        response.encoding = 'Shift_JIS'
        html = response.text
    except requests.exceptions.RequestException as e:
        print(f"Error fetching URL: {e}", file=sys.stderr)
        return

    soup = BeautifulSoup(html, 'html.parser')

    winners = []

    anchor = soup.find('a', attrs={'name': 'ironman'})
    if not anchor:
        print("Could not find the anchor tag.", file=sys.stderr)
        return

    table = anchor.find_next('table')
    if not table:
        print("Could not find the table after the anchor tag.", file=sys.stderr)
        return

    full_text = table.get_text(separator=' ', strip=True)

    # Split the text by the start of each entry
    entries = re.split(r'(?=#\d+|暫定|（[^）]+）)', full_text)

    for entry in entries:
        entry = entry.strip()
        if not entry:
            continue
        parsed = parse_entry(entry)
        if parsed:
            winners.append(parsed)

    print(json.dumps(winners, indent=2, ensure_ascii=False))

if __name__ == "__main__":
    scrape_winners()
