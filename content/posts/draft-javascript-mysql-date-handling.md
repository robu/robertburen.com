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

-   The builtin Javascript Date object is based on the Unix timestamp, which is the number of milliseconds since 1970-01-01 00:00:00 UTC. That is the _only_ built-in way to represent a point in time in Javascript.
-   MySQL has several date and time types, but the most common are DATE, TIME, DATETIME, and TIMESTAMP.
-   The MySQL date types are stores in the formats 'YYYY-MM-DD', 'YYYY-MM-DD HH:MM:SS', except for TIMESTAMP, which is also stored as a unix timestamp.

So far, these facts are fairly simple to understand. But the confusing mess that can be unleashed when trying to apply these facts in practice is a different story.

## What is a date and a time anyway?

I'm not going to get too philosophical here, but in the context of this article it's important to distinguish between a _specific point in time_, and a _human-readable representation of that point in time_, which may or may not be completely interchangable. Also, human representation is almost always local to a specific timezone, and implicitly a time period of an implied length.

## Just Javascript

The `Date()` object in Javascript is easy to understand, but it's not always easy to work with. Because of this, a number of libraries have been created to make working with dates in Javascript easier. Many of them choose to simply have their own representation of a date object, which gives them more flexibility in how they handle dates, and they are certainly powerful, albeit sometimes a bit heavy or even overwhelming. It also makes it a bit problematic when mixing dates from different sources using different libraries.

On the other side of the spectrum, we find [date-fns](https://date-fns.org/), which is a lightweight library that provides the most common date functions you need. It _only_ works with the native Javascript Date object, so it's easy to understand and also good to start using "just a bit" to see if it fits your needs -- you don't need to go all-in. To use it well, though, you need to understand how Javascript handles dates natively.

Specifically, you probably -- at some point -- need to factor in the very human complications of timezones, daylight saving time, and leap years. Even more likely, you need to treat period of time as an abstract concept. For example, you might talk about "a date", "a week", or "a month", but how do you best represent that in "milliseconds since 1970-01-01 00:00:00 UTC" (which is what the Javascript Date object is based on)?

I don't mean to be too theoretical here, so I'll try to illustrate with a simple example:

You have two dates, and have a business rule that they should be at least two days apart. How do you calculate that?

```javascript
    const MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24
    const firstDate = new Date('2024-05-01')
    const secondDate = new Date('2024-05-03')
    const diff = Math.abs(firstDate - secondDate)
    const diffDays = diff / MILLISECONDS_PER_DAY

    if (diffDays < 2) {
        console.log('Dates are too close')
    } else {
        console.log('Dates are OK')
    }
```

Simple enough? (You will get "Dates are OK" as output, because the dates are exactly 2 days apart.)

However, the dates are probably not hardcoded, but come from an external source -- from a database, API, or a form. So, what if the dates include timezone? And happen to be over a daylight saving time change?

```javascript
    // Remember: these date strings will come from an external source
    // Dates spanning the DST transition in Sweden
    const date1str = '2024-03-29T00:00:00+01:00'
    const date2str = '2024-03-31T00:00:00+02:00'

    const MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24
    const firstDate = new Date(date1str)
    const secondDate = new Date(date2str)
    const diff = Math.abs(firstDate - secondDate)
    const diffDays = diff / MILLISECONDS_PER_DAY

    if (diffDays < 2) {
        console.log('Dates are too close (unexpected)')
    } else {
        console.log('Dates are OK')
    }
```

Here you will get "Dates are too close (unexpected)", because even though we intend to check only the dates, these particular dates aren't exactly 24 hours long.

Let's add to the confusion...

## Enter MySQL

MySQL has a number of date and time types. I will focus on the very similar DATETIME and TIMESTAMP types. If you understand them, you can probably figure out the others as well.

Actually, just looking at those two types, you might think they are the same. But they are not.
