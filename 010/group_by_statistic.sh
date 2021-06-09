#!/bin/sh
# Агрегация строк
group_by_statistic() {
    sort | uniq -c | sort -rn
}
