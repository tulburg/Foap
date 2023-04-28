# Foap Country

Brief overview: Pulls countries data from two endpoints and display them in a table view with an option to select and expand to a detail view.

## Installation

```bash
cd [path]
pod install
```

Because of compatiblity issue between **Apollo iOS Client** and **Apollo Generators**, this project specifically requires pod install of **Apollo Client** version `0.9.2`. Also, you will need to modify one of the apollo files if you encounter this error
```text
Cannot convert parent type 'EnumeratedSequence<[Key]>' to expected type 'EnumeratedSequence<IndexingIterator<Array<Key>>>'
```
Change the Collection:61 to 
```swift
private var keyIterator: EnumeratedSequence<[Key]>.Iterator
```

#
### Build script
If necesary, please add this build script to **XCode** to compile/generate the `Api.Swift` using the schema. Please note, adding this code will update the API.swift with every build, if you ever need to modify the `countries.graphql`.

```bash
# Go to the build root and go back up to where SPM keeps the apollo iOS framework checked out.
cd "${BUILT_PRODUCTS_DIR}"

cd "Apollo/Apollo.framework"

APOLLO_SCRIPT_PATH="$(pwd)"

if [ -z "${APOLLO_SCRIPT_PATH}" ]; then
    echo "error: Couldn't find the CLI script in your checked out SPM packages; make sure to add the framework to your project."
    exit 1
fi

cd "${SRCROOT}/${TARGET_NAME}/Apollo/"
"${APOLLO_SCRIPT_PATH}"/check-and-run-apollo-cli.sh codegen:generate --target=swift --schema=schema.json API.swift

```
