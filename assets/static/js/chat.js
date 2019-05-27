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
    channel.push("new_msg", {userName: localStorage.getItem('userName'), body: message}, 10000)
        .receive("error", (reasons) => {
            console.log(reasons);
            refillInput(message);
        });
    clearInput();
};

const getUserNameHTML = (userName) => {
    const selfUserName = localStorage.getItem('userName');
    return selfUserName === userName ? `<p style="color:blue;">${userName}(You):</p>` : `<p style="color:red;word-break: break-all">${userName}:</p>`;
}

function addMessage({body, userName}) {
    if ($("#listMessages").children().length === 100) {
        $("#listMessages").children().get(0).remove();
    }

    $("#listMessages").append(
        `<li class="list-group-item" style="margin-top: 5px; margin-bottom: 5px; margin-right: 5px;">
            <div class="container-fluid"> 
                <div class="row align-items-center">
                    <div class="col-1">
                        ${getUserNameHTML(userName)}
                    </div>
                    <div class="col-11">
                        <p>${body}</p>
                    </div>
                </div>
            </div>
        </li>`
    )
    $("#messageBox").animate({scrollTop: $('#messageBox').get(0).scrollHeight}, 1);
};
