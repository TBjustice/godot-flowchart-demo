# Godot Flowchart Demo
## コンセプト
### `flowchart_node.tscn` および `flowchart_node.gd`
線を繋ぐ丸部分です。

当たり判定内にマウスがあるかどうかを保持する為に、
`mouse_entered`と`mouse_exited`シグナルを監視し、
変数`has_mouse`に記録しています。

また、後々の処理のために`FlowchartNode`というグループに登録しています。

### `flowchart_item.gd` 
タイトルをドラッグアンドドロップすることでアイテムを動かせるようにしている部分です。

もしも全く動かないまま左クリックを離したら`title_clicked`シグナルを発します。

### `flowchart_dialog.tscn` および `flowchart_dialog.gd`
GUI部分です。

`flowchart_item`を継承しており、`$VBoxContainer/Title`をタイトルバーとして登録しています。
これにより、`$VBoxContainer/Title`をドラッグアンドドロップする事で全体が動くようになります。

また、二つの`flowchart_node.tscn`を配置しており、右の物には`FlowchartNodeRight`という
グループを登録し、左の物には`FlowchartNodeLeft`というグループを登録しています。

### `flowchart.tscn` および `flowchart.gd`
本体です。

`_connection_list`は「右側の`FlowchartNode`」をkeyとし、「左側の`FlowchartNode`」をvalue
とするDictionaryです。

`_new_connection`は現在繋ごうとしている線の片方の端っこ（先にクリックしたほう）です。
`_new_connection_is_right`にそれが左右のどちらかの情報が入っています。

`find_nearest_flowchart_node()`関数ではグループを使って目的の`flowchart_node.tscn`を検索し
「当たり判定内の中でも、最もカーソルが近くにある物」を取得しています。

`_draw()`内で線を引いています。
