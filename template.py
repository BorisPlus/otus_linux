#!/usr/bin/python3
# run: python3 ./template.py  010.template.md 0
import sys
if __name__ == '__main__':
    # file_in = '008.template.md'
    file_in = sys.argv[1]
    rows_count_detail_limit = int(sys.argv[2]) if sys.argv[2].isnumeric() else 10
    if not file_in or not file_in.endswith('.template.md'):
        raise Exception('Not valid template name')
    file_out = file_in.replace('.template.md', '.md')
    with open(file_in) as f_in:
        with open(file_out, 'w') as f_out:
            for row_in in f_in:
                f_out.write(row_in.replace('[template]:', ''))
                if '[template]:' in row_in:
                    f_out.write('\n')
                    file_in_tmp = row_in.split('[template]:')
                    for lex in file_in_tmp[1:]:
                        # <details><summary>подробнее...</summary>
                        kv = lex.split('](', 1)
                        file_in_tmp = kv[1].split(')', 1)[0]
                        name = kv[0].strip(' [')
                        with open(file_in_tmp) as f_in_tmp:
                            rows_count = len(f_in_tmp.readlines())
                            if not file_in_tmp.endswith('.md'):
                                if rows_count > rows_count_detail_limit:
                                    f_out.write(f'<details><summary>см. {name}</summary>\n')
                                    f_out.write('\n')

                        if file_in_tmp.endswith('.sh'):
                            f_out.write('```')
                            f_out.write('shell')
                        elif file_in_tmp.endswith('.py'):
                            f_out.write('```')
                            f_out.write('python3')
                        elif file_in_tmp.endswith('.md'):
                            ...
                        else:
                            f_out.write('```')
                            f_out.write('properties')
                        f_out.write('\n')
                        with open(file_in_tmp) as f_in_tmp_2:
                            for row_in_tmp in f_in_tmp_2:
                                # if row_in_tmp.strip().startswith('#') and file_in_tmp.endswith(('.sh', '.py')):
                                #     continue
                                f_out.write(row_in_tmp)
                        if file_in_tmp.endswith('.md'):
                            ...
                        else:
                            f_out.write('\n```\n')
                        f_out.write('\n')
                        if not file_in_tmp.endswith('.md'):
                            if rows_count > rows_count_detail_limit:
                                f_out.write('</details>\n')
                                f_out.write('\n')
