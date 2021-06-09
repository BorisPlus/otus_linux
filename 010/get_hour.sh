#!/bin/sh
# Функция получения предыдущего часа в формате %d/%b/%Y:%H, который необходим для
# осуществления выборки из лог-файла с датой указанного формата
# Как использовать:
#
#         #!/bin/sh
#         . ./get_hour.sh
#         at_hour=$(get_hour)
#         echo $at_hour
#
get_hour() {
    # local d=$(LANG=en_EN date -d '1 hour ago' +%d/%b/%Y:%H)
    # Так как необходимо производить выборку за предыдущий час из лога,
    # то производится -d '1 hour ago'
    # При этом локаль принудительно LANG=en_EN, иначе генерирует дату в текущей локали
    # Поскольку в тестовом файле априори нет сведений за прошлый час 2021 года,
    # а только за 14-15 августа 2019 г., то искуссвенно перенесемся в то время,
    # вычев еще необходимо количесво часов, для 8 июля 2021 г. - это еще минус 15913 часов
    #
    corrective=15961
    formatted_hour=$(LANG=en_EN date -d "$corrective hour ago" +%d/%b/%Y:%H) #
    echo $formatted_hour
}

# Функция фильтрации содержимого файла по определенному часу
# Во внешней среде должны быть определены LOG_FILE и AT_HOUR
#
# Как использовать:
#
#         #!/bin/sh
#         #file: last_hour_test.sh
#         . ./last_hour.sh
#         AT_HOUR=$(get_hour)
#         echo $AT_HOUR
#         LOG_FILE="$1"
#         get_data_at_hour
#         exit 0
get_data_at_hour() {
    _LOG_FILE=${LOG_FILE}
    _AT_HOUR=${AT_HOUR}
    cat "${_LOG_FILE}" | grep "\[$_AT_HOUR:"
    exit 0
}
