$(window).on('load', function () {
    $('#nameEnterDialog').modal('show');
});


function enter() {
    const userName = $("#inputName").val();
    $("#buttonEnter").prop('disabled', true).html(
        `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>`
    );
    $.post("/chat",
        {
            user_name: userName
        },
        function (data) {
            $(location).attr('href', '/chat')
        });
}