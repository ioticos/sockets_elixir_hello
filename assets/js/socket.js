

import { Socket } from "phoenix"

const authSocket = new Socket("/auth_socket", { params: { token: window.authToken } });

authSocket.onOpen(() => console.log('authSocket Conectado!'))
authSocket.connect()

let channel = authSocket.channel("user:" + window.userId, {})

channel.join()
  .receive("ok", resp => {
    console.log("userChannel Conectado!", resp)
    console.log("")
    console.log("Enviando ping...")

    channel.push("ping:frase_de_prueba", { payload: 1 })
      .receive("ok", (resp) => {
        console.log("\t Respuesta recibida....")
        console.log(resp)

      })
      .receive("error", (resp) => console.error("Recibimos error luego de enviar ping", resp))
      .receive("timeout", (resp) => console.error("Recibimos timeout luego de enviar ping", resp))
  })
  .receive("error", resp => { console.log("Imposible unirnos al canal user:", resp) })


channel.on("salida", (payload) => {

  console.log("salida recibida con payload -> ", payload)


})

export default authSocket



/*

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
*/