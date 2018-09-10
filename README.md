# COSC346 - Assignment 1

## Learning Objectives

The aims of the assignment include the following learning objectives:
* To demonstrate programming skills using the Swift (version 4) programming language, and some of the Foundation classes.
* To employ in practice fundamental concepts in object-oriented programming such as polymorphism, inheritance, design patterns, coupling and cohesion.
* To reflect on the strengths and weaknesses of Swift and object-oriented programming techniques
* To deliver software that is well tested and documented.

## Problem Description

In this assignment you will design, implement, test, and document a tool for managing a media library. For the core of 
the assignment, you must depend on nothing more than the Foundation framework.

We have a large collection of media of assorted types (images, video, music, text documents) and we want to develop a library 
to help manage this collection. Attached to each of these types of media is a set of metadata. For example, an image may 
have some metadata describing where the photo was taken; music files may have an associated album/artist; videos may 
be produced by a studio, and so on.

The library should have the following features:
* import/export data from files (see: [File Import/Export](#file-importexport), [File Format](#file-format), and [Export Search Results to a File](#export-search-results-to-a-file))
* search metadata for keywords (see: [Searching](#searching))
* add/change/remove metadata keywords or values ([Changing Keyword/Values](#changing-keywordvalues))
* display a list of the files returned by the search (see: [Searching](#searching))

