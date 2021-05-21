
import { Socket } from "phoenix"

let socket = new Socket("/auth_socket", { params: { token: window.userToken } })

socket.connect()

let channel = socket.channel("tracked", {})

channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp)

    channel.push("ping")
      .receive("ok", (resp) => {
        console.log(resp)
        console.log("won't happen")
      })
      .receive("error", (resp) => console.error("won'thappenyet"))
      .receive("timeout", (resp) => console.error("pongmessagetimeout", resp))
  })
  .receive("error", resp => { console.log("Unable to join", resp) })



channel.on("send_ping", (payload) => {

  console.log("ping requested", payload)

  channel.push("ping:123")
    .receive("ok", (resp) => {
      console.log("ping:", resp.ping)
    
    })

})

export default socket
