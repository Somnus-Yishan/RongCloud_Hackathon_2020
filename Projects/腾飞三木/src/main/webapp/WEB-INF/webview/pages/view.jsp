<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>登录</title>
      <meta name="renderer" content="webkit" />
      <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
      <%@ include file="../tags/taglib.jsp"%>
      <script src="https://cdn.ronghub.com/RongIMLib-3.0.7.min.js"></script>
      <script src="https://cdn.ronghub.com/RongRTC-3.2.6.min.js"></script>
  </head>
  <style>
      .livefram{
          position: fixed;
          z-index: 2;
          background-color: black;
          width: 100%;
          height: 300px;
          top: 0;
          border-bottom: 0.2px solid #D0D0D0;
      }
      video{
          width: 100%;
          height: 100%;
          margin-top: -20px;
      }
      .wholepages{
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          width: 100%;
          height: 100%;
      }
      html{
          width: 100%;
          height: 100%;
          overflow-x:hidden;
      }
      body{
          background-color: #F8F8F8;
          font-family: -apple-system;
          font-family: "-apple-system", "Helvetica Neue", "Roboto", "Segoe UI", sans-serif;
      }
      .bottomfram{
          width: 100%;
          height: 45px;
          display: flex;
          flex-direction: row;
          justify-content: center;
          align-items: center;
          position: fixed;
      }

      button{
          border: 0;
          background-color: #FDCC08;
          font-size: 20px;
          color: white;
          font-family : 微软雅黑,宋体;
      }
      button:active{
          background-color: #eeeeee;
          color: #666666;
      }

      .chat-sender{
          clear:both;
          font-size: 80%;
      }

      .chat-sender div:nth-of-type(1){
          float: left;
      }
      .chat-sender div:nth-of-type(2){
          margin: 0 50px 2px 50px;
          padding: 0px;
          color: #848484;
          font-size: 70%;
          text-align: left;
      }
      .chat-sender div:nth-of-type(3){
          background-color: white;
          /*float: left;*/
          margin: 0 50px 10px 50px;
          padding: 10px 10px 10px 10px;
          border-radius:7px;
          text-indent: -12px;
      }

      .chat-receiver{
          clear:both;
          font-size: 80%;
      }
      .chat-receiver div:nth-of-type(1){
          float: right;
      }
      .chat-receiver div:nth-of-type(2){
          margin: 0px 50px 2px 50px;
          padding: 0px;
          color: #848484;
          font-size: 70%;
          text-align: right;
      }
      .chat-receiver div:nth-of-type(3){
          /*float:right;*/
          background-color: #b2e281;
          margin: 0px 50px 10px 50px;
          padding: 10px 10px 10px 10px;
          border-radius:7px;
      }

      .chat-receiver div:first-child img,
      .chat-sender div:first-child img{
          width: 40px;
          height: 40px;
          border-radius: 10%;
      }

      .chat-left_triangle{
          height: 0px;
          width: 0px;
          border-width: 6px;
          border-style: solid;
          border-color: transparent white transparent transparent;
          position: relative;
          left: -22px;
          top: 3px;
      }
      .chat-right_triangle{
          height: 0px;
          width: 0px;
          border-width: 6px;
          border-style: solid;
          border-color: transparent transparent transparent #b2e281;
          position: relative;
          right:-22px;
          top:3px;
      }
      .chat-notice{
          clear: both;
          font-size: 70%;
          color: white;
          text-align: center;
          margin-top: 15px;
          margin-bottom: 15px;
      }
      .chat-notice span{
          background-color: #cecece;
          line-height: 25px;
          border-radius: 5px;
          padding: 5px 10px;
      }
      .chatfram{
          margin-top: 300px;
      }
  </style>
  <body>
  <div class="wholepages">
      <div class="livefram" style="width: 100%;">asdada</div>
      <div class="chatfram" style="width: 100%;flex: 1">
          <div class="pages" style="width: 100%;height: 100%;margin-bottom: 45px;">
          </div>
          <div class="bottomfram" style="bottom: 0;">
              <div class="" style="width: 80%">
                  <input style="width: 100%;height: 40px;border: 0;padding-left: 20px;"/>
              </div>
              <div class="" style="width: 20%;">
                  <button style="height: 40px;width: 100%;">发  送</button>
              </div>
          </div>
      </div>
  </div>

  </body>
    <script>
        layui.use(['layer', 'form'], function(){
            var layer = layui.layer
                ,form = layui.form;

        });

        Date.prototype.Format = function (fmt) {
            var o = {
                "M+": this.getMonth() + 1, //月份
                "d+": this.getDate(), //日
                "H+": this.getHours(), //小时
                "m+": this.getMinutes(), //分
                "s+": this.getSeconds(), //秒
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                "S": this.getMilliseconds() //毫秒
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
        var config = {
            appkey: 'sfci50a7sx7ti',
        };
        var im = RongIMLib.init(config);
        var conversationList = []; // 当前已存在的会话列表
        im.watch({
            conversation: function(event){
                var updatedConversationList = event.updatedConversationList; // 更新的会话列表
                var data1 = new Date().Format("yyyy-MM-dd HH:mm:ss");
                $(".pages").append('          <div class="chat-notice">\n' +
                    '              <span>'+data1+' 会话列表已更新</span>\n' +
                    '          </div>')
                console.log('更新会话汇总:', updatedConversationList);
                console.log('最新会话列表:', im.Conversation.merge({
                    conversationList,
                    updatedConversationList
                }));
            },
            message: function(event){
                var message = event.message;
                console.log(message)
                var data1 = new Date().Format("yyyy-MM-dd HH:mm:ss");
                $(".pages").append('          <div class="chat-notice">\n' +
                    '              <span>'+data1+'</span>\n' +
                    '          </div>')
                if (message.senderUserId != "${param.userId}"){
                    $(".pages").append('<div class="chat-sender">\n' +
                        '              <div><img src="${ctx}/images/nav/nav_boy.png"></div>\n' +
                        '              <div id="'+message.messageUId+'">'+ message.senderUserId +'</div>\n' +
                        '              <div>\n' +
                        '                  <div class="chat-left_triangle"></div>\n' +
                        '                  <span> '+ message.content.content +'</span>\n' +
                        '              </div>\n' +
                        '          </div>')
                }else{
                    $(".pages").append('<div class="chat-receiver">\n' +
                        '              <div><img src="${ctx}/images/nav/nav_girl.png"></div>\n' +
                        '              <div id="'+message.messageUId+'">'+ message.senderUserId +'</div>\n' +
                        '              <div>\n' +
                        '                  <div class="chat-right_triangle"></div>\n' +
                        '                  <span> '+message.content.content+'</span>\n' +
                        '              </div>\n' +
                        '          </div>')
                }
                var mid = message.messageUId
                $("#"+mid)[0].scrollIntoView();
            },
            status: function(event){
                var status = event.status;
                var data1 = new Date().Format("yyyy-MM-dd HH:mm:ss");
                $(".pages").append('          <div class="chat-notice">\n' +
                    '              <span>'+data1+' 连接中...连接状态码：'+status+'</span>\n' +
                    '          </div>')
            },
            expansion: function(event) {
                var updatedExpansion = event.updatedExpansion;
                var deletedExpansion = event.deletedExpansion;
                console.log('消息扩展已更新', updatedExpansion);
                console.log('消息扩展被删除', deletedExpansion);
            },
            chatroom: function(event) {
                var updatedEntries = event.updatedEntries;
                console.log('聊天室 KV 存储监听更新:', updatedEntries);
            }
        });


        let rongRTC = new RongRTC({
            RongIMLib: RongIMLib,
            mode: RongRTC.Mode.LIVE,
            liveRole: RongRTC.ROLE.AUDIENCE
        });
        let { Room, Stream, Message, Device, Storage, StreamType} = rongRTC;
        var user = {
            token: '${param.token}'
        };
        // im 来自 RongIMLib.init 返回的实例，例如：var im = RongIMLib.init({ appkey: ' ' });
        im.connect(user).then(function(user) {
            console.log('链接成功, 链接用户 id 为: ', user.id);
            let stream = new Stream({
                /* 成员已发布资源，此时可按需订阅 */
                published: function(user){
                    stream.subscribe(user).then((user) => {
                        let {id, stream: {tag, mediaStream}} = user;
                    let node = document.createElement('video');
                    node.srcObject = mediaStream;
                    // 将 node 添加至页面或指定容器
                });
                },
                /* 成员已取消发布资源，此时需关闭流 */
                unpublished: function(user){
                    stream.unsubscribe(user);
                },
            });
            stream.subscribe({liveUrl:"${param.liveUrl}"}).then((res) => {
                let { mediaStream} = res;
                let node = document.createElement('video');
                node.autoplay = true;
                node.srcObject = mediaStream;
                //document.body.appendChild(node);
                $(".livefram").append(node)
        });
            var data1 = new Date().Format("yyyy-MM-dd HH:mm:ss");
            $(".pages").append('          <div class="chat-notice">\n' +
                '              <span>'+data1+' 连接成功，用户 id 为：'+user.id+'</span>\n' +
                '          </div>')
            //加入聊天室
            var chatRoom = im.ChatRoom.get({
                id: '${param.roomId}'
            });
            chatRoom.join({
                count: 20 // 进入后, 自动拉取 20 条聊天室最新消息
            }).then(function() {
                var data1 = new Date().Format("yyyy-MM-dd HH:mm:ss");
                $(".pages").append('          <div class="chat-notice">\n' +
                    '              <span>'+data1+' 加入自习室成功，欢迎用户：'+user.id+'</span>\n' +
                    '          </div>')
                $("button").click(function () {
                    //发送消息
                    chatRoom.send({
                        messageType: RongIMLib.MESSAGE_TYPE.TEXT, // 'RC:TxtMsg'
                        content: {
                            content: $("input").val() // 文本内容
                        }
                    }).then(function(message){
                        var data1 = new Date().Format("yyyy-MM-dd HH:mm:ss");
                        $(".pages").append('          <div class="chat-notice">\n' +
                            '              <span>'+data1+'</span>\n' +
                            '          </div>')
                        $(".pages").append('<div class="chat-receiver">\n' +
                            '              <div><img src="${ctx}/images/nav/nav_girl.png"></div>\n' +
                            '              <div id="send'+message.messageUId+'">${param.userName}</div>\n' +
                            '              <div>\n' +
                            '                  <div class="chat-right_triangle"></div>\n' +
                            '                  <span> '+message.content.content+'</span>\n' +
                            '              </div>\n' +
                            '          </div>')
                        var mid = message.messageUId
                        $("#send"+mid)[0].scrollIntoView();
                        $("input").val("")
                    });
                })
            });
        }).catch(function(error) {
            var data1 = new Date().Format("yyyy-MM-dd HH:mm:ss");
            $(".pages").append('          <div class="chat-notice">\n' +
                '              <span>'+data1+' 用户登录失败，请刷新页面重试，错误码：'+error.code+' '+error.msg+'</span>\n' +
                '          </div>')
        });
    </script>
</html>
