#!/usr/bin/python3
# run: python3 ./details.py  test.details.md 0
import sys

if __name__ == '__main__':
    DO_NOT_TO_DETAIL = "10"

    current_not_details = None
    if len(sys.argv) == 2:
        current_not_details = DO_NOT_TO_DETAIL
    elif len(sys.argv) == 3:
        current_not_details = sys.argv[2]
    else:
        print(f"python3 ./details.py  x.details.md {DO_NOT_TO_DETAIL}")
        exit(0)
    import re
    DETAILS_TEMPLATE = r"(\[details([ (\-\w)*]*)\]\:(\[([\w|_|\"|,|\*|\+|\(|\[|\)|\]|`|:|\-|\.|\s|_|\\|/|\@]*)\]\(([\w|\*|\+|\(|\[|\)|\]|\-|\.|\"|,|\s|=|_|\\|/|\@]*)\)))"

    file_in = sys.argv[1]
    rows_count_detail_limit = int(current_not_details) if current_not_details.isnumeric() else int(DO_NOT_TO_DETAIL)

    if not file_in or not file_in.endswith('.details.md'):
        raise Exception('Not valid details name')

    file_out = file_in[:-(len('.details.md'))] + '.md'

    with open(file_in) as f_in:
        with open(file_out, 'w') as f_out:
            for row_in in f_in:
                source_row = row_in
                replace_to = ''
                rows_to_write = []
                # rows_to_write.append(row_to_write)
                was_find = False
                md = ''
                for regexp_lexems in re.findall(DETAILS_TEMPLATE, source_row):
                    was_find = True
                    replace_from = regexp_lexems[0]
                    replace_to = regexp_lexems[0]
                    md = regexp_lexems[2]
                    screen_name = regexp_lexems[3]
                    file_path = regexp_lexems[4]

                    options = set(regexp_lexems[1].split(' '))
                    no_link = True if '--no-link' in options else False
                    if no_link:
                        replace_to = f'`{screen_name}`'
                    else:
                        replace_to = f'[{screen_name}]({file_path})'

                    source_row = source_row.replace(f'{replace_from}', f'{replace_to}', 1)

                    rows_to_write.append('\n')
                    file_in_tmp = file_path
                    rows_count = 0
                    with open(file_in_tmp) as f_in_tmp:
                        rows_count = len(f_in_tmp.readlines())
                        if not file_in_tmp.endswith('.md'):
                            if rows_count > rows_count_detail_limit or rows_count == 0:
                                rows_to_write.append(f'<details><summary>см. {screen_name}</summary>\n')
                                rows_to_write.append('\n')
                    # if rows_count:
                    if file_in_tmp.endswith('.sh'):
                        rows_to_write.append('```')
                        rows_to_write.append('shell')
                    elif file_in_tmp.endswith('.py'):
                        rows_to_write.append('```')
                        rows_to_write.append('python3')
                    elif file_in_tmp.endswith('.md'):
                        ...
                    elif file_in_tmp.endswith('.yml'):
                        rows_to_write.append('```')
                        rows_to_write.append('properties')
                    else:
                        rows_to_write.append('```')
                        rows_to_write.append('text')
                    rows_to_write.append('\n')

                    with open(file_in_tmp) as f_in_tmp_2:
                        for row_in_tmp in f_in_tmp_2:
                            rows_to_write.append(row_in_tmp)

                    if file_in_tmp.endswith('.md'):
                        ...
                    else:
                        # if rows_count:
                        rows_to_write.append('\n```\n')

                    # if rows_count:
                    rows_to_write.append('\n')

                    if not file_in_tmp.endswith('.md'):
                        if rows_count > rows_count_detail_limit or rows_count == 0:
                            rows_to_write.append('</details>')
                            rows_to_write.append('\n')

                if not was_find or (was_find and source_row.strip('\n\r\t ') != f'`{screen_name}`'):
                    rows_to_write.insert(0, source_row)
                if was_find:
                    a = 1
                    pass
                    pass

                for r in rows_to_write:
                    f_out.write(r)
