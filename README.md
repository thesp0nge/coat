# coat - COntract And Test 

## Introduction

In May 2012 on my [blog](http://armoredcode.com) I wrote a
[post](http://armoredcode.com/blog/is-by-design-by-contract-the-solution-for-safe-coding)
about ideas coming from design by contract and how to apply them to safe coding
used alongside Behavior Driven Development.

Than _coat_ project was born. The idea is to create a DSL to describe class
contract and having a preprocessor creating:

1. the class skeleton code with both pre-conditions and post-conditions for each method
2. a lightweight documentation for each method extracted from the contract
3. the test case to drive BDD

## The coat language

The coat language will be a descriptive language with English keywords
formatted using indentation like Python programming language.

The language will be:

1. easy (both to read than to use)
2. compact (very few keywords, I promise... just to describe class contract
   with the world, I don't want to get into your implementation details)

### Hello world

A classic that never goes old fashioned is the hello world project. 

Since coat is not born to produce bytecode or native executable machine code,
the goal is to describe how it has to behave a class that writes "Hello world"
as standard output.

Let's look at our first coat program.

``` hello_world.coat
\# As in ruby, this is a comment. We will follow the same naming convention
\# used in ruby to translate filenames in class.
contract "HelloWorld":

  \# Classes can have pre and post conditions as well.
  \# Pre conditions can be environment variables or command line switches
  \# Usually post conditions deal with output or they can be empty if there is
  \# no particular output or if your class is not design to be executed from command
  \# line as example.
  pre: none
  \# Here "read", "from" and "stout" are coat keywords to be used to build the
  \# BDD spec file.
  post: read "Hello world" from stdout

  \# We declare here the public apis for the HelloWorld class.
  \# An empty newline will be the methods separator
  api
    \# A public say_hello method here with pre and post conditions. I don't
    \# care about how you would like to achieve it. True to be told, it's fine if
    \# after coat preprocessing, your hello_world.rb file won't to anything. 
    \#
    \# Remember, you must look for hello_world_spec.rb and use BDD.
    say_hello
      pre: none
      post: "Hello world"
```

This would be the contract for an "Hello world" project.
Now it's time to run coat creating class and tests.

```
$ coat hello_world.coat
```

Two file will be created in the same directory you launched coat:

1. hello_world.rb containing the "HelloWorld" class skeleton
2. hello_world_spec.rb containing the test cases for the "HelloWorld" class

Then you can start your BDD or TDD (both of them are fine) work over the "Hello
World" project.
