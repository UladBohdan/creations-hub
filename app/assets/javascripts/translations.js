app.config(['$translateProvider', function ($translateProvider) {
    $translateProvider.translations('en', {
        'FILE_NOT_CHOSEN_EDIT': "File not chosen. Your profile image won't be changed",
        'FILE_NOT_CHOSEN_NEW': "File not chosen. Your profile will be created without profile image",
        'UPLOAD_SUCCESS_EDIT': "Image was successfully uploaded! Update your profile with you current password.",
        'UPLOAD_SUCCESS_NEW': "Image was successfully uploaded!",

        fiction: "Fiction",
        fantasy: "Fantasy",
        comedy: "Comedy",
        science: "Science",
        cooking: "Cooking",
        programming: "Programming",
        others: "Others",
        all: "all",
        recently_created: "Recently created",
        recently_updated: "Recently updated",
        most_rated: "Most rated",
        any: "any",
        four: "4",
        six: "6",
        ten: "10",
        no_limit: "no limit",

        author: "Author",
        commentator: "Commentator",
        newbie: "Newbie",
        polyglot: "Polyglot",
        night_reader: "Night reader"
    });

    $translateProvider.translations('be', {
        'FILE_NOT_CHOSEN_EDIT': "Файл не абраны. Выява профіля не зменіцца",
        'FILE_NOT_CHOSEN_NEW': "Файл не абраны. Профіль будзе створаны без выявы",
        'UPLOAD_SUCCESS_EDIT': "Выява была паспяхова загружаная! Абнавіце Ваш профіль з дапамогай пароля.",
        'UPLOAD_SUCCESS_NEW': "Выява была паспяхова загружаная.",

        fiction: "Фантастыка",
        fantasy: "Фэнтэзі",
        comedy: "Камедыя",
        science: "Навука",
        cooking: "Кухарства",
        programming: "Праграмаванне",
        others: "Іншае",
        all: "Усе",
        recently_created: "Нядаўна створаныя",
        recently_updated: "Нядаўна абноўленыя",
        most_rated: "Найлепш ацэненыя",
        any: "Любыя",
        four: "4",
        six: "6",
        ten: "10",
        no_limit: "Без абмежаванняў",

        author: "Аўтар",
        commentator: "Каментатар",
        newbie: "Навічок",
        polyglot: "Паліглот",
        night_reader: "Чытаю ўночы"
    });

    $translateProvider.preferredLanguage('en');
}]);