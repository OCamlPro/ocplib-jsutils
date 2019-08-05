open Js_of_ocaml
open Js
open Browser_utils

class type window = object
  method alwaysOnTop : bool t prop
  method focused : bool t prop
  method height : int optdef prop
  method id : int optdef prop
  method incognito : bool t prop
  method left : int optdef prop
  method sessionId : js_string t optdef prop
  method state : js_string t optdef prop
  method tabs : Tabs_utils.tab t js_array t optdef prop
  method title : js_string t optdef prop
  method top : int optdef prop
  method _type : js_string t optdef prop
  method width : int optdef prop
end

class type getInfo = object
  method populate : bool optdef prop
  method windowTypes : js_string t js_array t optdef prop
end

class type createData = object
  method allowScriptsToClose : bool t optdef prop
  method cookieStoreId : int optdef prop
  method focused : bool t optdef prop
  method height : int optdef prop
  method incognito : bool t optdef prop
  method left : int optdef prop
  method state : js_string t optdef prop
  method tabId : int optdef prop
  method titlePreface : js_string t optdef prop
  method top : int optdef prop
  method _type : js_string t optdef prop
  method url : js_string t optdef prop
  method url_arr : js_string t js_array t optdef prop
  method width : int optdef prop
end

class type updateInfo = object
  method drawAttention : bool t optdef prop
  method focused : bool t optdef prop
  method height : int optdef prop
  method left : int optdef prop
  method state : js_string t optdef prop
  method titlePreface : js_string t optdef prop
  method top : int optdef prop
  method width : int optdef prop
end

class type windows = object
  method _WINDOW_ID_NONE : int prop
  method _WINDOW_ID_CURRENT : int prop
  method get : int -> getInfo t optdef -> window t promise t meth
  method getCurrent : getInfo t optdef -> window t promise t meth
  method getLastFocused : getInfo t optdef -> window t promise t meth
  method getAll : getInfo t optdef -> window t js_array t promise t meth
  method create : createData t optdef -> window t promise t meth
  method update : int -> updateInfo t -> window t promise t meth
  method remove : int -> unit promise t meth
  method onCreated : window t event t prop
  method onRemoved : int event t prop
  method onFocusChanged : int event t prop
end

let make_createData ?url ?url_l ?tabId ?left ?top ?width ?height ?focused ?typ
    ?state ?allowScriptsToClose ?cookieStoreId ?titlePreface () =
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
  data##allowScriptsToClose <- optdef bool allowScriptsToClose;
  data##cookieStoreId <- Optdef.option cookieStoreId;
  data##titlePreface <- optdef string titlePreface;
  data

let make_updateInfo ?left ?top ?width ?height ?focused ?drawAttention ?state
    ?titlePreface () =
  let data : updateInfo t = Unsafe.obj [||] in
  data##left <- Optdef.option left;
  data##top <- Optdef.option top;
  data##width <- Optdef.option width;
  data##height <- Optdef.option height;
  data##focused <- optdef bool focused;
  data##drawAttention <- optdef bool drawAttention;
  data##state <- optdef string state;
  data##titlePreface <- optdef string titlePreface;
  data

let windows : windows t = Unsafe.variable "browser.windows"

let get ?info id f = jthen windows##get(id, Optdef.option info) f
let getCurrent ?info f = jthen windows##getCurrent(Optdef.option info) f
let getLastFocused ?info f = jthen windows##getLastFocused(Optdef.option info) f
let getAll ?info f =
  jthen windows##getAll(Optdef.option info) (fun a -> f (array_to_list a))
let create ?info ?callback () =
  jthen_opt windows##create(Optdef.option info) callback
let update ?callback id info =
  jthen_opt windows##update(id, info) callback
let remove ?callback id = jthen_opt windows##remove(id) callback

let onCreated handler =
  windows##onCreated##addListener(wrap_callback handler)
let onRemoved handler =
  windows##onRemoved##addListener(wrap_callback handler)
let onFocusChanged handler =
  windows##onFocusChanged##addListener(wrap_callback handler)
