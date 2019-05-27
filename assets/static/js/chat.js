const socket = new Socket("/socket", {params: {token: window.userToken}});

socket.connect();

const channel = socket.channel("room:lobby", {});

channel.join()
    .receive("ok", resp => {
        console.log("Joined successfully", resp)
    })
    .receive("error", resp => {
        console.log("Unable to join", resp)
    });

channel.on("new_msg", msg => addMessage(msg));

$(window).on('load', function () {

    $("#btnChat").on("click", function () {
        const message = $("#inputChat").val();
        send(message)
    });

    $("#inputChat").on("Enter", function (event) {
        send(message)
    })
});

function clearInput() {
    $("#inputChat").val('')
};

function refillInput(val) {
    $("#inputChat").val(val)
}

function send(message) {
    channel.push("new_msg", {userName: window.userName, body: message}, 10000)
        .receive("error", (reasons) => {
            console.log(reasons);
            refillInput(message);
        });
    clearInput();
};

function addMessage({body, userName}) {
    $("#listMessages").append(
        `<li class="left clearfix list-group-item" style="margin-top: 5px; margin-bottom: 5px; margin-right: 5px;">
            <div class="chat-body clearfix">
                <div class="header">
                    <strong class="primary-font">${userName}</strong> <small class="pull-right text-muted">
                </div>
                <p>${body}</p>
            </div>
        </li>`
    )
    $("#messageBox").animate({scrollTop: $('#messageBox').get(0).scrollHeight}, 500);

}
