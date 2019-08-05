open Js_of_ocaml
open Js
open Browser_utils

class type window = object
  method id : int optdef prop
  method focused : bool t prop
  method top : int optdef prop
  method left : int optdef prop
  method width : int optdef prop
  method height : int optdef prop
  method tabs : Tabs_utils.tab t js_array t optdef prop
  method incognito : bool t prop
  method _type : js_string t optdef prop
  method state : js_string t optdef prop
  method alwaysOnTop : bool t prop
  method sessionId : js_string t optdef prop
end

class type getInfo = object
  method populate : bool optdef prop
  method windowTypes : js_string t js_array t optdef prop
end

class type createData = object
  method url : js_string t optdef prop
  method url_arr : js_string t js_array t optdef prop
  method tabId : int optdef prop
  method left : int optdef prop
  method top : int optdef prop
  method width : int optdef prop
  method height : int optdef prop
  method focused : bool t optdef prop
  method incognito : bool t optdef prop
  method _type : js_string t optdef prop
  method state : js_string t optdef prop
  method setSelfAsOpener : bool t optdef prop
end

class type updateInfo = object
  method left : int optdef prop
  method top : int optdef prop
  method width : int optdef prop
  method height : int optdef prop
  method focused : bool t optdef prop
  method drawAttention : bool t optdef prop
  method state : js_string t optdef prop
end

class type windows = object
  method get : int -> getInfo t optdef -> (window t -> unit) callback -> unit meth
  method getCurrent : getInfo t optdef -> (window t -> unit) callback -> unit meth
  method getLastFocused : getInfo t optdef -> (window t -> unit) callback -> unit meth
  method getAll : getInfo t optdef -> (window t js_array t -> unit) callback -> unit meth
  method create : createData t optdef -> (window t -> unit) callback optdef -> unit meth
  method update : int -> updateInfo t -> (window t -> unit) callback optdef -> unit meth
  method remove : int -> (unit -> unit) callback optdef -> unit meth
  method onCreated : window t event t prop
  method onRemoved : int event t prop
  method onFocusChanged : int event t prop
end

let make_createData ?url ?url_l ?tabId ?left ?top ?width ?height ?focused ?typ
    ?state ?selfOpener () =
  let data : createData t = Unsafe.obj [||] in
  data##url <- optdef string url;
  data##url_arr <- optdef array_of_list_str url_l;
  data##tabId <- Optdef.option tabId;
  data##left <- Optdef.option left;
  data##top <- Optdef.option top;
  data##width <- Optdef.option width;
  data##height <- Optdef.option height;
  data##focused <- optdef bool focused;
  data##_type <- optdef string typ;
  data##state <- optdef string state;
  data##setSelfAsOpener <- optdef bool selfOpener;
  data

let make_updateInfo ?left ?top ?width ?height ?focused ?drawAttention ?state () =
  let data : updateInfo t = Unsafe.obj [||] in
  data##left <- Optdef.option left;
  data##top <- Optdef.option top;
  data##width <- Optdef.option width;
  data##height <- Optdef.option height;
  data##focused <- optdef bool focused;
  data##drawAttention <- optdef bool drawAttention;
  data##state <- optdef string state;
  data

let windows : windows t = Unsafe.variable "chrome.windows"

let get ?info id f = windows##get(id, Optdef.option info, wrap_callback f)
let getCurrent ?info f = windows##getCurrent(Optdef.option info, wrap_callback f)
let getLastFocused ?info f = windows##getLastFocused(Optdef.option info, wrap_callback f)
let getAll ?info f =
  windows##getAll(Optdef.option info, wrap_callback (fun a -> f (array_to_list a)))
let create ?info ?callback () =
  windows##create(Optdef.option info, optdef_wrap callback)
let update ?callback id info =
  windows##update(id, info, optdef_wrap callback)
let remove ?callback id = windows##remove(id, optdef_wrap callback)

let onCreated handler =
  windows##onCreated##addListener(wrap_callback handler)
let onRemoved handler =
  windows##onRemoved##addListener(wrap_callback handler)
let onFocusChanged handler =
  windows##onFocusChanged##addListener(wrap_callback handler)
