// RUN: rm -rf %t
// RUN: split-file %s %t
// RUN: sed -e "s@INPUT_DIR@%{/t:regex_replacement}@g" \
// RUN: %t/reference.output.json.in >> %t/reference.output.json
// RUN: %clang_cc1 -extract-api --pretty-sgf -triple arm64-apple-macosx \
// RUN:   -x c++-header %t/input.h -o %t/output.json -verify

// Generator version is not consistent across test runs, normalize it.
// RUN: sed -e "s@\"generator\": \".*\"@\"generator\": \"?\"@g" \
// RUN: %t/output.json >> %t/output-normalized.json
// RUN: diff %t/reference.output.json %t/output-normalized.json

//--- input.h
template<typename T> T Foo = T(3.14);

template<> int Foo<int>;
/// expected-no-diagnostics

//--- reference.output.json.in
{
  "metadata": {
    "formatVersion": {
      "major": 0,
      "minor": 5,
      "patch": 3
    },
    "generator": "?"
  },
  "module": {
    "name": "",
    "platform": {
      "architecture": "arm64",
      "operatingSystem": {
        "minimumVersion": {
          "major": 11,
          "minor": 0,
          "patch": 0
        },
        "name": "macosx"
      },
      "vendor": "apple"
    }
  },
  "relationships": [],
  "symbols": [
    {
      "accessLevel": "public",
      "declarationFragments": [
        {
          "kind": "keyword",
          "spelling": "template"
        },
        {
          "kind": "text",
          "spelling": " <"
        },
        {
          "kind": "keyword",
          "spelling": "typename"
        },
        {
          "kind": "text",
          "spelling": " "
        },
        {
          "kind": "genericParameter",
          "spelling": "T"
        },
        {
          "kind": "text",
          "spelling": "> "
        },
        {
          "kind": "typeIdentifier",
          "preciseIdentifier": "c:t0.0",
          "spelling": "T"
        },
        {
          "kind": "text",
          "spelling": " "
        },
        {
          "kind": "identifier",
          "spelling": "Foo"
        },
        {
          "kind": "text",
          "spelling": ";"
        }
      ],
      "identifier": {
        "interfaceLanguage": "c++",
        "precise": "c:@Foo"
      },
      "kind": {
        "displayName": "Global Variable Template",
        "identifier": "c++.var"
      },
      "location": {
        "position": {
          "character": 23,
          "line": 0
        },
        "uri": "file://INPUT_DIR/input.h"
      },
      "names": {
        "navigator": [
          {
            "kind": "identifier",
            "spelling": "Foo"
          }
        ],
        "subHeading": [
          {
            "kind": "identifier",
            "spelling": "Foo"
          }
        ],
        "title": "Foo"
      },
      "pathComponents": [
        "Foo"
      ],
      "swiftGenerics": {
        "parameters": [
          {
            "depth": 0,
            "index": 0,
            "name": "T"
          }
        ]
      }
    },
    {
      "accessLevel": "public",
      "declarationFragments": [
        {
          "kind": "keyword",
          "spelling": "template"
        },
        {
          "kind": "text",
          "spelling": " <> "
        },
        {
          "kind": "typeIdentifier",
          "preciseIdentifier": "c:I",
          "spelling": "int"
        },
        {
          "kind": "text",
          "spelling": " "
        },
        {
          "kind": "identifier",
          "spelling": "Foo"
        },
        {
          "kind": "text",
          "spelling": "<"
        },
        {
          "kind": "typeIdentifier",
          "preciseIdentifier": "c:I",
          "spelling": "int"
        },
        {
          "kind": "text",
          "spelling": ">;"
        }
      ],
      "identifier": {
        "interfaceLanguage": "c++",
        "precise": "c:@Foo>#I"
      },
      "kind": {
        "displayName": "Global Variable Template Specialization",
        "identifier": "c++.var"
      },
      "location": {
        "position": {
          "character": 15,
          "line": 2
        },
        "uri": "file://INPUT_DIR/input.h"
      },
      "names": {
        "navigator": [
          {
            "kind": "identifier",
            "spelling": "Foo"
          }
        ],
        "subHeading": [
          {
            "kind": "identifier",
            "spelling": "Foo"
          }
        ],
        "title": "Foo"
      },
      "pathComponents": [
        "Foo"
      ]
    }
  ]
}
