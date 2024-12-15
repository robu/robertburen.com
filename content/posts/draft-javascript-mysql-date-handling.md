---
date: 2024-12-02T17:07:17+01:00
draft: true
title: Javascript Mysql Date Handling
lang: en
categories:
- Software Development
tags:
- Javascript
- Mysql
- Date
- Tech
summary: My learnings when fighting timezones and date formats in Javascript and MySQL.
---

Some basic facts:

-   The builtin Javascript Date object is based on the Unix timestamp, which is the number of milliseconds since 1970-01-01 00:00:00 UTC.
-   MySQL has several date and time types, but the most common are DATE, TIME, DATETIME, and TIMESTAMP.
-   The MySQL date types are stores in the formats 'YYYY-MM-DD', 'YYYY-MM-DD HH:MM:SS', except for TIMESTAMP, which is also stored as a unix timestamp.

So far, these facts are fairly simple to understand. But the confusing mess that can be unleashed when trying to apply these facts in practice is a different story.

## What is a date and a time anyway?

I'm not going to get too philosophical here, but in the context of this article it's important to distinguish between a _specific point in time_, and a _human-readable representation of that point in time_, which may or may not be completely interchangable.

## Just Javascript

The `Date()` object in Javascript is easy to understand, but it's not always easy to work with. Because of this, a number of libraries have been created to make working with dates in Javascript easier. Many of them choose to simply have their own representation of a date object, which gives them more flexibility in how they handle dates, and they are certainly powerful, albeit sometimes a bit heavy or even overwhelming. It also makes it a bit problematic when mixing dates from different sources using different libraries.

On the other side of the spectrum, we find [date-fns](https://date-fns.org/), which is a lightweight library that provides the most common date functions you need. It _only_ works with the native Javascript Date object, so it's easy to understand and also good to start using "just a bit" to see if it fits your needs -- you don't need to go all-in. To use it well, though, you need to understand how Javascript handles dates natively.
