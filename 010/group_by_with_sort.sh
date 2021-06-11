#!/bin/sh
# Агрегация строк (с сортировкой)
group_by_with_sort() {
    sort | uniq -c | sort -rn
}
