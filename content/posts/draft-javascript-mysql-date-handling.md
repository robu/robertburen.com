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
summary: My learnings when fighting timezones and date formats in Javascript and MySQL.
---

Some basic facts:

-   The builtin Javascript Date object is based on the Unix timestamp, which is the number of milliseconds since 1970-01-01 00:00:00 UTC.
-   MySQL has several date and time types, but the most common are DATE, TIME, DATETIME, and TIMESTAMP.
-   The MySQL date types are stores in the formats 'YYYY-MM-DD', 'YYYY-MM-DD HH:MM:SS', except for TIMESTAMP, which also stored as a unix timestamp.

So far, these facts are fairly simple to understand. But the confusing hell that can be unleashed when trying to apply these facts in practice is a different story.
