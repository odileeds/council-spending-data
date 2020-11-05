# Council Spending Data

Processed/cleaned versions of public body spending data files. These are further processed for the [ODI Leeds Public Body Spending Explorer](https://odileeds.org/projects/council-spending/) but are provided here so that other people don't have to deal with the horror of inconsistencies in columns, CSV-validity, dates, currency values etc.

The original files often come in monthly publications (but sometimes follow other release schedules). A monthly release won't always contain all the spending in that month; sometimes it'll show up in later months just due to the practicality of accounting. We've renamed the files to make them more consistent between councils. The file names will be in a `YYYY-MM.csv` or `YYYY-MM-X.csv` style where `YYYY` is the year, `MM` is the release month, and `X` will be a postfix for cases where multiple files are published for a specific month e.g. when they split card payments from other payments. In some cases `MM` will be a period e.g. `P01` where data are published that way rather than monthly.

We do a cleaning step that attempts to automatically remove header lines (or entire SQL queries in the case of Darlington) from the top of the CSV, put [dates in a consistent format](https://github.com/odileeds/open-data-tips#dates), removes trailing commas (that double the file size in the case of some Leeds data), and deal with any [other data gremlins](https://docs.google.com/document/d/1WEf54JwSnOcUV7F70AXVkg50LzDuD3lFSAAa47nX4F0/edit). These cleaned versions will have a `_clean` addition to the filename. We also make a reduced file (`_processed`) that attempts to use consistent column headings as used in our [visualisation tool](https://odileeds.org/projects/council-spending/):

  * `Payment Date`,
  * `Amount`,
  * `Benificiary Name`,
  * `Organisational Unit`
