"""Extract COVID-19 time-series data for India from the raw dataset.

Reads the raw time-series-countries.txt file, filters rows matching India,
and writes the date, confirmed, recovered, and dead counts to a CSV file
in the data/ directory.
"""

import csv
import re

INPUT_FILE = "../data/time-series-countries.txt"
OUTPUT_FILE = "../data/date-India-confirmed-recovered-dead.csv"

# Pattern: date, "India", optional province, lat, lon, confirmed, recovered, dead
INDIA_PATTERN = re.compile(
    r"^(\d{4}-\d{1,2}-\d{1,2}),India,,"  # date, country, empty province
    r"[^,]*,[^,]*,"                        # lat, lon
    r"(\d+),(\d+),(\d+)"                   # confirmed, recovered, dead
)


def extract_india_data(input_path, output_path):
    """Parse the raw text file and write India rows to CSV."""
    rows = []
    with open(input_path, "r") as fh:
        for line in fh:
            match = INDIA_PATTERN.search(line)
            if match:
                date, confirmed, recovered, dead = match.groups()
                rows.append((date, confirmed, recovered, dead))

    with open(output_path, "w", newline="") as fh:
        writer = csv.writer(fh)
        writer.writerow(["Date", "c", "r", "d"])
        writer.writerows(rows)

    print(f"Wrote {len(rows)} rows to {output_path}")


if __name__ == "__main__":
    extract_india_data(INPUT_FILE, OUTPUT_FILE)
