# Mixtape.json

### Installation
Run `bundle install`

### To Run Program
`bin/mixtape <input-file> <changes-file> <output-file>`

For example: `bin/mixtape data/mixtape.json data/changes.json output.json`

Sample mixtape.json and changes.json files are available for testing under the `data` folder
The example full output is at `output.json`

### Tests
To run tests run `rspec spec`

### Thoughts on How to Scale Large Input files
At some point very large files will be too big to be read into memory or too slow to be practically useful.

There are tradeoffs to consider including additional technical overhead, additional dependencies, and cost.

- The most obvious way to handle a very large file, particularly the mixtape.json, and particularly if there is some permanence to the data/we need to keep it for repeated reference, would be store the information in a relational database. The tables of a standard db can hold far more than the memory of an individual computer, and query languages (SQL, ActiveRecord, etc.) provide easy ways to access and manipulate the data in the tables. This seems to make particular sense for the mixtape.json information which is already structured in a relational way.

- Chunk the data. For example the Ruby class IO has methods that allow one to read line by line or to read or write a certain number of bytes. This would be more useful for the changes than the mixtape itself, because we need to be able to search through the whole mixtape for some of the changes.

- Get more computing power. Use AWS, Azure, GCP, etc. to get more memory/computing power to quickly read in and process even very large files. This would add both a technical dependency and financial costs.
