#!/usr/bin/python3
# run: ./template.py  008.template.md
import sys
if __name__ == '__main__':
    # file_in = '008.template.md'
    file_in = sys.argv[1]
    with open(file_in) as f_in:
        for row_in in f_in:
            f_out.write(row_in.replace('[template]:', ''))
            if '[template]:' in row_in:
                f_out.write('\n')
                file_in_tmp = row_in.split('[template]:')
                for lex in file_in_tmp[1:]:
                    # <details><summary>подробнее...</summary>

                    file_in_tmp = lex.split('](', 1)[1].split(')', 1)[0]

                    with open(file_in_tmp) as f_in_tmp:
                        rows_count = len(f_in_tmp.readlines())
                        if rows_count > rows_count_detail_limit:
                            f_out.write('<details><summary>подробнее...</summary>\n')
                            f_out.write('\n')

                    f_out.write('```')
                    if file_in_tmp.endswith('.sh'):
                        f_out.write('shell')
                    elif file_in_tmp.endswith('.py'):
                        f_out.write('python3')
                    else:
                        f_out.write('properties')
                    f_out.write('\n')
                    with open(file_in_tmp) as f_in_tmp:
                        for row_in_tmp in f_in_tmp:
                            f_out.write(row_in_tmp)
                    f_out.write('\n```\n')
                    f_out.write('\n')
                    if rows_count > rows_count_detail_limit:
                        f_out.write('</details>\n')
                        f_out.write('\n')
