(* Copyright 2001, 2002 b8_bavard, b8_fee_carabine, INRIA *)
(*
    This file is part of mldonkey.

    mldonkey is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    mldonkey is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with mldonkey; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*)


type server_msg
type client_msg


  
type server_sock = TcpBufferedSocket.t
type client_sock = TcpBufferedSocket.t

  
val verbose : bool ref
val server_send : TcpBufferedSocket.t -> server_msg -> unit
val client_send : TcpBufferedSocket.t -> client_msg -> unit
val servers_send : TcpBufferedSocket.t list -> server_msg -> unit

  
  (*
val client_handler : 
  (DonkeyProtoClient.t -> TcpBufferedSocket.t -> unit) ->
TcpBufferedSocket.t -> int -> unit
*)
  
val cut_messages : (string -> 'a) ->
    ('a -> TcpBufferedSocket.t -> 'b) -> TcpBufferedSocket.t -> int -> unit
  
val client_handler2 : 'a option ref ->
    (DonkeyProtoClient.t -> TcpBufferedSocket.t -> 'a option) ->
    ('a -> DonkeyProtoClient.t -> TcpBufferedSocket.t -> unit) ->
  TcpBufferedSocket.t -> int -> unit
  
  (*
val server_handler :
  (DonkeyProtoServer.t -> TcpBufferedSocket.t -> unit) ->
  TcpBufferedSocket.t -> int -> unit
*)
  
val udp_send:  UdpSocket.t -> Unix.sockaddr -> DonkeyProtoServer.t -> unit
val udp_handler :
  (DonkeyProtoServer.t -> UdpSocket.udp_packet -> unit) ->
  UdpSocket.t -> UdpSocket.event -> unit
  
val propagate_working_servers : (Ip.t * int) list -> unit
val udp_basic_handler : 
  (string -> UdpSocket.udp_packet -> unit) -> UdpSocket.t -> 
  UdpSocket.event -> unit

val server_msg_to_string : server_msg -> string
val client_msg_to_string : client_msg -> string
  
val server_msg : DonkeyProtoServer.t -> server_msg
val client_msg : DonkeyProtoClient.t -> client_msg
  
val direct_server_send : TcpBufferedSocket.t -> DonkeyProtoServer.t -> unit
val direct_client_send : TcpBufferedSocket.t -> DonkeyProtoClient.t -> unit
val direct_servers_send : TcpBufferedSocket.t list -> DonkeyProtoServer.t -> unit

  
val new_string :  client_msg -> string -> unit
  
val udp_send_if_possible : UdpSocket.t -> 
  TcpBufferedSocket.bandwidth_controler -> 
  Unix.sockaddr -> DonkeyProtoServer.t -> unit