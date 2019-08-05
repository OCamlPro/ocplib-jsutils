open Js_min
open Js
open Browser_utils
open Runtime_utils
open Tabs_utils

class type tabs = object
  method _TAB_ID_NONE : js_string t prop
  method captureTab : int optdef -> imageDetails t optdef -> js_string t promise t meth
  method captureVisibleTab : int optdef -> imageDetails t optdef -> js_string t promise t meth
  method connect : int -> 'a t optdef -> port meth
  method create : createProperties t -> tab t promise t meth
  method detectLanguage : int optdef -> (js_string t -> unit) callback -> js_string t promise t meth
  method discard : int -> unit promise t meth
  method discard_arr : int js_array t -> unit promise t meth
  method duplicate : int -> tab t promise t meth
  method executeScript : int optdef -> details t -> 'a t js_array t promise t meth
  method get : int -> tab t promise t meth
  method getAllInWindow : int optdef -> tab t js_array t promise t meth
  method getCurrent : tab t promise t meth
  method getZoom : int optdef -> number t promise t meth
  method getZoomSettings : int optdef -> zoomSettings t promise t meth
  method hide : int -> js_string t js_array t promise t meth
  method hide_arr : int js_array t -> js_string t js_array t promise t meth
  method highlight : highlightInfo t -> Dom_html.window t promise t meth
  method insertCSS : int optdef -> details t meth
  method move : int -> moveProperties -> tab t promise t meth
  method move_arr : int js_array t -> moveProperties -> tab t js_array t promise t meth
  method moveInSuccession : int js_array t -> int optdef -> moveInSuccessionOptions t optdef -> unit meth
  method print : unit meth
  method printPreview : unit promise t meth
  method query : queryInfo t -> tab t js_array t promise t meth
  method reload : int optdef -> reloadProperties t optdef -> unit promise t meth
  method remove : int -> unit promise t meth
  method remove_arr : int js_array t -> unit promise t meth
  method removeCSS : int optdef -> details t -> unit promise t meth
  method saveAsPDF : pageSettings t -> js_string t promise t meth
  method sendMessage : int -> 'a t -> details t optdef -> json t promise t meth
  method setZoom : int optdef -> number t -> unit promise t meth
  method setZoomSettings : int optdef -> zoomSettings t -> unit promise t meth
  method show : int -> unit promise t meth
  method show_arr : int js_array t -> unit promise t meth
  method toggleReaderMode : int optdef -> unit promise t meth
  method update : int optdef -> tab t -> tab t promise t meth
  method onActivated : 'a t event t prop
  method onAttached : (int, 'a t) event2 t prop
  method onCreated : tab t event t prop
  method onDetached : (int, 'a t) event2 t prop
  method onHighlighted : 'a t event t prop
  method onMoved : (int, 'a t) event2 t prop
  method onRemoved : (int, 'a t) event2 t prop
  method onReplaced : (int, int) event2 t prop
  method onUpdated : (int, 'a t, tab t) event3 t prop
  method onZoomChanged : 'a t event t prop
end
let tabs : tabs t = Unsafe.variable "browser.tabs"
let tab_id_none () = tabs##_TAB_ID_NONE

let captureTab ?id ?options f =
  jthen tabs##captureTab(Optdef.option id, Optdef.option options)
    (fun s -> f (to_string s))
let captureVisibleTab ?id ?options f =
  jthen tabs##captureVisibleTab(Optdef.option id, Optdef.option options)
    (fun s -> f (to_string s))
let connect ?info id = tabs##connect(id, Optdef.option info)
let create ?callback tab = jthen_opt tabs##create(tab) callback
let detectLanguage ?id f =
  jthen tabs##detectLanguage(Optdef.option id, wrap_callback (fun s -> f (to_string s)))
    (fun s -> f (to_string s))
let discard ?callback id = jthen_opt tabs##discard(id) callback
let discard_list ?callback ids =
  jthen_opt tabs##discard_arr(array_of_list ids) callback
let duplicate ?callback id = jthen_opt tabs##duplicate(id) callback
let executeScript ?id ?callback details =
  jthen_opt tabs##executeScript(Optdef.option id, details) callback
let get id f = jthen tabs##get(id) f
let getCurrent f = jthen tabs##getCurrent() f
let getZoom ?id f = jthen tabs##getZoom(Optdef.option id) (fun x -> f (float_of_number x))
let getZoomSettings ?id f = jthen tabs##getZoomSettings(Optdef.option id) f
let hide id = tabs##hide(id)
let hide_list ids = tabs##hide_arr(array_of_list ids)
let highlight ?callback info = jthen_opt tabs##highlight(info) callback
let insertCSS ?id () = tabs##insertCSS(Optdef.option id)
let move ?callback id props = jthen_opt tabs##move(id, props) callback
let move_list ?callback ids props =
  jthen_opt tabs##move_arr(array_of_list ids, props) callback
let moveInSuccession ?id ?options ids =
  tabs##moveInSuccession(array_of_list ids, Optdef.option id, Optdef.option options)
let print () = tabs##print()
let printPreview () = tabs##printPreview()
let query info f = jthen tabs##query(info) f
let reload ?id ?props ?callback () =
  jthen_opt tabs##reload(Optdef.option id, Optdef.option props) callback
let remove ?callback id = jthen_opt tabs##remove(id) callback
let removeCSS ?id details = tabs##removeCSS(Optdef.option id, details)
let saveAsPDF settings f = jthen tabs##saveAsPDF(settings) (fun s -> f (to_string s))
let remove_list ?callback id = jthen_opt tabs##remove_arr(array_of_list id) callback
let sendMessage ?details ?callback id message =
  jthen_opt tabs##sendMessage(id, message, Optdef.option details) callback
let setZoom ?id ?callback factor =
  jthen_opt tabs##setZoom(Optdef.option id, number_of_float factor) callback
let setZoomSettings ?id props f =
  jthen tabs##setZoomSettings(Optdef.option id, props) f
let show id = tabs##show(id)
let show_list ids = tabs##show_arr(array_of_list ids)
let toggleReaderMode ?id () = tabs##toggleReaderMode(Optdef.option id)
let update ?id ?callback props =
  jthen_opt tabs##update(Optdef.option id, props) callback

let onActivated handler =
  tabs##onActivated##addListener(wrap_callback handler)
let onAttached handler =
  tabs##onAttached##addListener(wrap_callback handler)
let onCreated handler =
  tabs##onCreated##addListener(wrap_callback handler)
let onDetached handler =
  tabs##onDetached##addListener(wrap_callback handler)
let onHighLighted handler =
  tabs##onHighlighted##addListener(wrap_callback handler)
let onMmoved handler =
  tabs##onMoved##addListener(wrap_callback handler)
let onRemoved handler =
  tabs##onRemoved##addListener(wrap_callback handler)
let onReplaced handler =
  tabs##onReplaced##addListener(wrap_callback handler)
let onUpdated handler =
  tabs##onUpdated##addListener(wrap_callback handler)
let onZoomChanged handler =
  tabs##onZoomChanged##addListener(wrap_callback handler)