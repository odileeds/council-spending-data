# Council Spending Data

Processed/cleaned versions of public body spending data files. These are further processed for the [ODI Leeds Public Body Spending Explorer](https://odileeds.org/projects/council-spending/) but are provided here so that other people don't have to deal with the horror of inconsistencies in columns, CSV-validity, dates, currency values etc.

We create one directory per public body. Each directory contains an `index.json` file and several sub-directories.

## index.json

Each public body has an `index.json` file to define which files/dates are available. It is of the form:

```javascript
{
	"dir": "leeds",
	"src": {
		"tool": "",
		"urls": ["http://datamillnorth.org/api/action/package_show?id=council-spending"],
		"files": []
	},
	"columns": {
		"map": {
			"Amount": ["Net amount","NetAmount","Net Amount £","Net Amount"],
			"Beneficiary Name": ["Supplier name","SupplierName","Supplier Name","Benificiary Name"],
			"Organisation Label": ["Body name"],
			"Organisational Unit": ["Service Label","Service label","ServiceLabel"],
			"Payment Date": ["Date","Date paid","Date Paid","DatePaid","Payment date"]
		}
	},
	"files": []
}
```

The `dir` defines the output directory name for the visualisation. The properties `src` and `columns` define some properties of the source that are used by our automated process that processes some organisations. 

## Files 

The `files` array in `index.json` defines a time-ordered array of files that cover the spending data. Each file gets an entry of the form:

```javascript
{
	"format": "csv",
	"month": "2010-12",
	"url": "https://datamillnorth.org/download/council-spending/e374718a-e01a-430d-8650-bbe15cd638f4/spending_2010_12.csv",
	"name": "December 2010",
	"file": "2010-12.csv"
}
```

where `format` should be `csv`, `month` defines the date (ISO8601), `url` links to the original file, `name` is a human-readable version of the name (often the label given by the public body themselves), and `file` gives the filename (within the `processed/` sub-directory).

The original files often come in monthly publications (but sometimes follow other release schedules). A monthly release won't always contain all the spending in that month; sometimes it'll show up in later months just due to the practicality of accounting. We've renamed the files to make them more consistent between councils. The file names will be in a `YYYY-MM.csv` or `YYYY-MM-X.csv` style where `YYYY` is the year, `MM` is the release month, and `X` will be a postfix for cases where multiple files are published for a specific month e.g. when they split card payments from other payments. In some cases `MM` will be a period e.g. `P01` where data are published that way rather than monthly.

We do a cleaning step that attempts to automatically remove header lines (or entire SQL queries in the case of Darlington) from the top of the CSV, put [dates in a consistent format](https://github.com/odileeds/open-data-tips#dates), removes trailing commas (that double the file size in the case of some Leeds data), and deal with any [other data gremlins](https://docs.google.com/document/d/1WEf54JwSnOcUV7F70AXVkg50LzDuD3lFSAAa47nX4F0/edit). These cleaned versions are stored in the `clean/` sub-directory. We also make a reduced file (stored in `processed/`) that attempts to use consistent column headings as used in our [visualisation tool](https://odileeds.org/projects/council-spending/):

  * `Payment Date` - [ISO8601 date format](https://en.wikipedia.org/wiki/ISO_8601) e.g. "2020-02-02"
  * `Amount` - A number without commas
  * `Benificiary Name` - a string
  * `Organisational Unit` - a string
  * `Company Number` (optional - for future use)
  * `Charity Number` (optional - for future use)

## Contributing

If there is a public body that doesn't currently exist here that you'd like to add you can. 

1. Create a directory. Don't use spaces in the name. Try to keep it short and avoid picking names that might be used by other bodies.
2. Create an `index.json` file making sure to include `files` and `dir` properties.
3. Save the processed files (use the exact column headings above) in a `processed/` sub-directory.
4. Submit a pull request.
