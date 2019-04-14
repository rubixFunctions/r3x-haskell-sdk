# RubiX Haskell SDK

[![CircleCI](https://circleci.com/gh/rubixFunctions/r3x-haskell-sdk.svg?style=svg)](https://circleci.com/gh/rubixFunctions/r3x-haskell-sdk)
[![License](https://img.shields.io/badge/-Apache%202.0-blue.svg)](https://opensource.org/s/Apache-2.0)


## Prerequisites
Stack is needed to build and execute SDK, it can be downloaded from [here](https://www.haskell.org/downloads/)

## Hackage 
[SDK Hackage Package](http://hackage.haskell.org/package/r3x-haskell-sdk)

## Usage
To build the SDK run :
```
$ stack build
```
To execute SDK run :
```
$ stack exec r3x-haskell-sdk-exe
```
alternatively you can run the script `run.sh`:
```
$ ./run.sh
```

## Verify
To quickly verify the SDK as showcase was built and can be viewed [here](https://github.com/rubixFunctions/r3x-docs/tree/master/samples/r3x-haskell-showcase), you can use the pre build showcase image by:
```
$ docker run -p 8080:8080 quay.io/rubixfunctions/r3x-haskell-showcase
$ curl localhost:8080
    {"message":"Hello RubiX!!!"}%
```

## Documentation
For full information on how to use the SDK and deploy a function to Knative, refer to our [Documentation here.](https://github.com/rubixFunctions/r3x-docs/blob/master/README.md)

## License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details