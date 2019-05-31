$(window).on('load', function () {
    $("#btnChat").on("click", function () {
        const message = $("#inputChat").val();
        send(message)
    });

    const inputChat = $("#inputChat");

    inputChat.keypress(function (event) {
        const message = inputChat.val();
        if (event.keyCode === 13 && message) {
            send(message)
        }
    });

    inputChat.keyup(function (event) {
        const message = inputChat.val();
        if (!message) {
            $("#btnChat").prop('disabled', true);
        } else {
            $("#btnChat").prop('disabled', false);
        }
    });
});

const userName = localStorage.getItem('userName');

if(!userName) {
    $(location).attr('href', '/')
}

const socket = new Socket("/socket", {params: {userName: userName}});

socket.connect();
socket.onClose(() => {
    channel.push('leave', {}, 10000);
});

const channel = socket.channel(`room:lobby`, {});

channel.join()
    .receive("ok", resp => {
        console.log("Joined successfully", resp)
    })
    .receive("error", resp => {
        console.log("Unable to join", resp)
    });

channel.on("new_msg", msg => addMessage(msg));
channel.on("system_event", msg => addSystemEvent(msg))

function clearInput() {
    $("#inputChat").val('');
    $("#btnChat").prop('disabled', true);
}

function refillInput(val) {
    $("#inputChat").val(val)
}

function send(message) {
    channel.push("new_msg", {body: message}, 10000)
        .receive("error", (reasons) => {
            console.log(reasons);
            refillInput(message);
        });
    clearInput();
}

const getUserNameHTML = (userName) => {
    const selfUserName = localStorage.getItem('userName');
    return selfUserName === userName ? `<p style="color:blue;">${userName}(You):</p>` : `<p style="color:red;word-break: break-all">${userName}:</p>`;
};

function addToListMessages(htmlString) {
    const listMessages = $("#listMessages");
    if (listMessages.children().length === 100) {
        listMessages.children().get(0).remove();
    }
    listMessages.append(htmlString);
    const messageBox = $("#messageBox");
    messageBox.animate({scrollTop: messageBox.get(0).scrollHeight}, 1);
}

function addSystemEvent({body}) {
    const messageHtml =
        `<li class="list-group-item" style="margin-top: 5px; margin-bottom: 5px; margin-right: 5px;">
            <div class="container-fluid"> 
                <div class="row align-items-center">
                    <div class="col-1">
                        <p style="color:black;">System:</p>
                    </div>
                    <div class="col-11">
                        <p>${body}</p>
                    </div>
                </div>
            </div>
        </li>`;
    addToListMessages(messageHtml);
}

function addMessage({body, userName}) {
    const messageHtml =
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
        </li>`;
    addToListMessages(messageHtml);
}
