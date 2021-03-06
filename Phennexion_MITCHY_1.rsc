�   �Y��	7W�vW�  first_byondclass.dms <byondclass name="firstclass">

<!-- Our CSS styling goes here -->

<style>
	#firstclass {
	    width: 200px;
	    height: 100px;

	    position: absolute;
	    left: calc(50% - 200px/2);
	    top: calc(50% - 100px/2);

	    background: #00FF00;
	    box-shadow: 0px 0px 10px #fff;
	    border-radius: 15px;

	    padding: 15px;
	    text-align: center;
	}

	.button {
	    width: 80px;
	    height: 25px;

	    margin: auto;
	    border: 1px solid grey;
	    background: #BABABA;
	}
</style>

<!-- Our JavaScript code goes here -->

<script>
{
	fn: {
		output: function(obj) {
			if(obj.hasOwnProperty("text")) {
				this.ui.content.innerHTML = obj.text;
			}
		}
	}
}
</script>

<div id="content" class="content"></div>    <!-- The div that will be containing our text. -->
<div id="button" class="button">Okay</div>  <!-- The div representing our confirmation button. -->

</byondclass>6   �d�	7W��W  index.dms <html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
</head>
<body>
	<div id="main" byondclass="child" skinparams="left=map;is-vert=true;width=0;zoom=0;">
		<div id="map" byondclass="map"></div>
	</div>
	<div id="output" byondclass="output"></div>
	<div id="input" byondclass="input"></div>
	<div id="firstclass" byondclass="firstclass" skinparams="is-visible=false"></div>
	<div id="bags" byondclass="bags" skinparams="is-visible=true"></div>
</body>
</html>
<style>
	.byond_output {
		background-color: #000000;
		color: #fff;
		width: 400px;
	    height: 200px;

	    position: absolute;
	    left: calc(85% - 400px/2);
	    top: calc(85% - 200px/2);
	    box-shadow: 0px 0px 10px #fff;
	    border-radius: 15px;

	    padding: 15px;
	}
	Alternatively, you can use the selector #output. If you want to select a class, however, you always
	have to prefix it with "byond_".
	*/

</style>

macro
	T return "say"
macro
	I return "bags"
macro
	O return "clearinv"�    B�;;W;;W�  Inventory.dms <byondclass name="bags">

<!-- Our CSS styling goes here -->

<style>
	#bags {
	    width: 200px;
	    height: 200px;

	    position: absolute;
	    left: calc(90% - 200px/2);
	    top: calc(20% - 200px/2);
		color: #fff;
	    background: #444444;
	    box-shadow: 0px 0px 5px #000000;
	    border-radius: 5px;

	    padding: 15px;
	    text-align: center;
	}
	.item {
		width: 40px;
		height: 40px;
		border-left: 2px solid;
		border-top: 2px solid;
		border-right: 2px solid;
		border-bottom: 2px solid;
		border-color: #333333;
		color: #00FF00;
		display: flex;
		background: #444444;
		background-size: 32px 32px;
		background-repeat: no-repeat;
		background-position: center center;
		flex-shrink: 0;
	}
	.inv_slot {
		width: 40px;
		height: 40px;
		background: #00FFFF;
		display: flex;
		flex-shrink: 0;
	}
	.button {
	    width: 80px;
	    height: 25px;

	    margin: auto;
	    border: 1px solid grey;
	    background: #BABABA;
	}
</style>

<!-- Our JavaScript code goes here -->
<script>
(function(){
	function clickhandler(e) {

		byond.fn.topic("action=look;value=" + e.target.getAttribute("data-ref"));

		e.stopPropagation(); // stops handlers below in the DOM tree from triggering
		e.preventDefault();
	};

    return {
        fn: {
            output: function(obj,sub) {
					var e = this.elem;
					var a, i, html;

					// decode and fix up the json_encode'd list from the output
					var string = byond.htmlDecode(obj.text);
					var id, m, icon='';
					string = string.replace(/\n+$/,'');
					string = string.replace(/^\n+/,'');
					string = string.replace(/<br\s*\/?>/gi,'');


					// make a new array that will parse the fixed up string from above
					var inv_array = JSON.parse(string);

					// build the UI Divs
					html = '<div id=header class=header>Inventory</div>';
					html += '<div id=inv class=inventory></div>';
					e.innerHTML = html;

					// build item slots
					var slots_html ='';
					for(i = 1; i < 9; i++) {
						 slots_html += '<div id=inv_slot'+i+' class=inv_slot>'+i+'</div>';
					}
					document.getElementById("inv").innerHTML += slots_html;
					var html_item = '';
                // loop through the parsed array to find the objects
					for(var key in inv_array) {
						if(string.hasOwnProperty(key)) {
						// find the first key and parse it too, so that we can dig into the items actual data

							item = inv_array[key];
							id = item.ref;
							if(id && (m=id.match(/\[0x([0-9a-f]+)\]/i))) {
									id = parseInt(m[1],16);
								icon = '<img class=item atom='+id+'>';
								var bgurl = this.atomIcon(id);  // gets the atom's icon and makes a url for it
							}
							console.log(item);
							console.log(JSON.stringify(item));
							// add the item's properties into it's own div!
							html_item = '<div data-ref='+item.ref+' data-quality='+item.quality+' style=\'background-image: url('+bgurl+');\' class=item ></div>';
							var slot = 'inv_slot'+item.inv_position
							console.log(slot);
							document.getElementById(slot).innerHTML = html_item;
							}
					}

					// set the inventory output to the bags div
					//console.log(document.getElementById("inv").innerHTML);
					//document.getElementById("inv").innerHTML = html_items;

					// cycle through all the existing  .items and ensure there's a click listener
					a = e.querySelectorAll('.item');
					for(i=a.length; i--;) a[i].addEventListener('click', clickhandler); // adds the event click to the items and uses clickhandler function above

					// https://youtu.be/0sfPDJiMTXk
            }
        }
    };
})()
</script>


</byondclass>ass>{  ,	P@	7Wr_W]  minerals.dmi �PNG

   IHDR   @       ��   PLTE���   bbb�  yx��   tRNS @��f   pzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT S��$?/U��3%���7��L+J�M��᪊RS�*TVp�s� �&6>��   �IDAT(�c`<@�f�t�б��uU ����VM����@�V-����GjD�����U����������V�Z	�����X� �����+��Z�B����w`��5+Bׇ@��J  #OC�hy�*    IEND�B`��  z[�	7W�UW�  options.dmi �PNG

   IHDR   �   �   �>a�   �zTXtDescription  x����
�0Eי���[[�f#)�E�ю�`���͹p8%���v0��;�$���vG�!}��פ�y9)���(��F�� �KLШH]�y�wv��_)����W̚Tσ{A���ܷ�y�B%�����ބ�BVd�Mw  �IDATx��{l�������VJ)�Ta��5B�*�D"m1�D#	�B��R$���H��E)bE�X ��Z�\D�rі�\LI��lwf��s:;�-����7�$�ng��;=���=��*=z�0p0�����x�}����
��J�[���Ym������lݺEQPUEQ �4]���|��a(�����0t]��F��!��E�0�@�4ic	Ā}Q���Ɋ���J�l{YY�GV��<]�ea�0PUMӀ��N1�*�"�$�)ޛ����l]��477�U$�f�+ 
�sD�3�#�	E�p����LX�u]�@@:�ڂD�TEV�8.B���9��Wq\`�}'ㅖ�c�,s�z���TU����@X��=O��D9�g��۾��BK�L���L�4<�|�����j�s�mM�Dkߎ}���"����ȑ#�}�Yo�q/��s���JQ���ٳ�={�`0H �O�>������}[�`�׽�}���ٳg ����E����w2��&G�}(Z��K��Jo���d֬YC �-Кܙ�������̟?���ry��yx'Dd�.nf�f
�4��*��bD����ٱc�`0����t�~?�-�����'���̆�֭[D�nm����u���ܹs����on�"��vK��ٷ���*����
U���zƍGqqq���ϟϱcǨ��d߾}�9s���{/lҦ���	&�}����6ۊv̚��|>�͛�|���z���fh�&�˛�w2R b������z����4iR��UUe�޽��呚�*���ݛy��q��qz��!��A���:uj�5�	�j������x뭷8x0z#y��3g{�졹�M��B���QA{��LXG(�]���,Y�$"������ۛ7o���R~>p�@���a�ԩS�5*,ˏ��>���ONN�j�曚���� 77�g�}����0�A�'�ڳ�D�"��(|���|�����x������bРA���K\�~=��8n%2jԨ�*o�d_�fϞ�O?�t���ilڴ�_|������AD1I;�Q����С�7o��|�3f -�=z4�O������SOE��9sfTc�`��cǆ����~?>���S�r�ȑ���ד��MUU����`ؔ�վ�Q�e��믿f���m>|8 {��h��Y�dID���t�^��a���a-P����y�����MӘ1c�����u��tT�.�bŊ�-_еkW ���Î���2{�l�.]�'�|@||�,��Ǐ�k�.��9�S�Gy�����,�9s���z"Z�+�T���_��������h�".^���k�d�ht�ޝg�yF�n��?�fݺu�I555TVVF8��"S���lƎ�fA�'geeѽ{��e���e٫W�F-����3�&kȆ���Y�X�`'N$===j�U�V��i��\� �E���Ν;#
�ꫯOyy9�Ǐ����K�.ѳgO >�裨��~?�w�S��C�k����)S��!�@�6D�B���o�[�Nϝ;�իWIHH��JV�NF�$���,Y����������o�`����8q���B


8uꔌ�O�fӦM������7�ev.0�7}��a�ƍ���̉o���������C���h����JWU���BƍQx���a�1���:3gΤs�� �9s�������q���+9���V��_����˖-["D�+innf���lٲ���DN�<)���w2*��$�.�ŋ�l�2�~�,�i,_�<l4p��e֮]KZZ������g��,Z�H����fill���B?��(..&!!��z(l��܍�B!B���u����`[���ңGc����M�����ɓ's�ҥ�2Ç���s���
4hyyyQ�a��ӧO�=���y%�<�3}��;b�7���O�ΦM��z���4III���p��1rrr�r�
��h�4>� .$%%��6k޻�Vf�
��v����3�;��BŒ���waɘy�\T��!Cعs'�P���Zjjj���E�u� <� )))�.7q��E�3��hC���[��[�!��۱�D""��� ���G�~��ӧO��w��
��\�V���c��֡���� sh�¨8m�� k�5o�0���۾�	��!5�l����V޺�"��[[�pv�w"r"H`�{����V�5;�Z��G��״Ӿ���2W��	�fN���T8D�DN ݘ�����m��(N�z������R����F܎��p8� �+ ��
��p8jffV�ݔ.�@f�}.��vG�������78W ���q�pl�;a/� w�VbA .6ȶ��L,��F\8W G���ջ؋�#���!Tl~^}��y���ջ؋� >�
��p8� N,`��7`'vC�|HԽ$33+���H��}��׻��ہY��Y`ӿ�w��pb�p�W ���q�p\8W ������Jw�lf�p8� �M�+ ��
��p8� �+ ��
��p8� �+ ��
��p8� ��zW 6b��B�� vc��	
\8���҃� �%��p�p\8W ����a�ݴ�|�$�*ٷy��7^��������z������{�]>@ffֺo��}^VV��s�]`VVԇC�K����q;���e�'�{AVV�QQQ��(�����܎�i躎��e�@Q<�a��<�0Zu$��E�0�@�4icĈ`� b�1v#���x�s��t]��� ���477�4�^�z������F�4�E(III$''s��Q�&�)�+� ���e����|ǎ�Y�����0ӱcG�L�Bss3���;v�ȤI�x�嗥0�g�$W �F ]�e �(Ν;G^^�t����||>MMMaǯ\���իy��G2d���a���1 s@K�-�"Z�� ^�������(++k��UUU:h�*��|�_ �m�@(�aY�ksRh�V�}�]X�l�M���]@,av�H�� TUK�������摅�^���XTVVz�&an��<0�P(�n�4���A`��f�;������_8̜X�ԩ�@���8���	�w�}�^_�F�CUU���7�ZIJJbŊ��ߟ��4����رcD9��ͶbW ���b"�����xPUU�Z���a�ʕ�����Y�|9.\�%[�$ 7	4!�}�>��a[EE+W������G�F-#���߅bW  ��E`��i��޺uk��I����lrC��Ņ�.� Dعs�穪ʘ1c�z�|��wQ����$����^D����^2���2ͫw�a0`� 222"��u�3f�����C�%---l%�<܌�@�  9����Hii)t�Ё��8�~�m���Cmm-���~�����:ӦM#�kv�҅�#GҡC�uX�~��!�CEa�ƍ$&&RYYIQQ�}� ~���{M��B2��a���ҹ�y�0����>�J�@���\;�d�+�|��\�x��~���|222�֭cƌa����3@�I���?��������A� Ç������Y����u�����(�]����z���(((��7ߤgϞ���+�۷�ѣGS[[�����6���JCC_~�%?��C� ***(..&999b���bEQ�2e
�W������k�2w�\���Y�x19999r$���2�����>�^�
��$��^����ݻwSRRB(�wޡ������s�ci��͈=77�����
�ڵ�0v�X�����;~��+ Z|���Y�|9��� >|�iӦ���O3hР;j��%�{��XHJJ"??�ٳgs��	���X�j999�?^����y׮]c۶m�����F,�	p`B�t�B~~>o��'O����g���������f��ܺ1�=\�8ݻwgժU���QZZJSS����-���z�ׯ���h�ƶm��>w��B$�@؞��]������~�o���Ç�|�r��ILLd������3l�0z�i��矔���V����
 1{�<S7b��|�I���9s����\�t���� 99�^�zѿ���hnn�� E�w�ެ\��`0�����v�
��M�m}{�S�N������*#�yϠ��r��XN�JHH����zĦ;q a�2;޼,,6r�� ;����7�y��+ˋ�f��+ ��'���l��~Rfh�R    IEND�B`�)  ,��	7W.$W  player.dmi �PNG

   IHDR           I��   PLTE���  3���   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   EIDAT�c`��? 	�?@�����$��o``��� n���l �(F�������F0 
 % �G#��ĳ�    IEND�B`�-  Q~�$	7W.$W  Turfs.dmi �PNG

   IHDR           I��   PLTE �  � )�F   izTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT S)�(��X��3%���7��L+J�M���\�\�� 9�+ySJ	   RIDAT�c` 0���� , DJ	0Bh�*&4��S� �I�l� �b���10$0�d஁  �w/�&oE    IEND�B`��   0�	7WnyW�   Inv.dmi �PNG

   IHDR           I��   PLTE   �z=�   tRNS @��f   IzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J eW?� ��mK}�;   IDAT�c`�   � �O�    IEND�B`�H   �D->W->W�  Inventory.dms <byondclass name="bags">

<!-- Our CSS styling goes here -->

<style>
	#bags {
	    width: 200px;
	    height: 200px;

	    position: absolute;
	    left: calc(90% - 200px/2);
	    top: calc(20% - 200px/2);
		color: #fff;
	    background: #444444;
	    box-shadow: 0px 0px 5px #000000;
	    border-radius: 5px;

	    padding: 15px;
	    text-align: center;
	}
	.item {
		width: 40px;
		height: 40px;

		background: #444444;
		background-size: 32px 32px;
		background-repeat: no-repeat;
		background-position: center center;
		display: inline-block;
	}
	.inv_slot {
		width: 42px;
		height: 42px;
		flex-shrink: 0;
		display: inline-block;
		margin:0;
		vertical-align:top;
		border-left: 2px solid;
		border-top: 2px solid;
		border-right: 2px solid;
		border-bottom: 2px solid;
		border-color: #333333;
	}
	.button {
	    width: 80px;
	    height: 25px;

	    margin: auto;
	    border: 1px solid grey;
	    background: #BABABA;
	}
</style>

<!-- Our JavaScript code goes here -->
<script>
(function(){
	function clickhandler(e) {

		byond.fn.topic("action=look;value=" + e.target.getAttribute("data-ref"));

		e.stopPropagation(); // stops handlers below in the DOM tree from triggering
		e.preventDefault();
	};

    return {
        fn: {
            output: function(obj,sub) {
					var e = this.elem;
					var a, i, html;

					// decode and fix up the json_encode'd list from the output
					var string = byond.htmlDecode(obj.text);
					var id, m, icon='';
					string = string.replace(/\n+$/,'');
					string = string.replace(/^\n+/,'');
					string = string.replace(/<br\s*\/?>/gi,'');


					// make a new array that will parse the fixed up string from above
					var inv_array = JSON.parse(string);

					// build the UI Divs
					html = '<div id=header class=header>Inventory</div>';
					html += '<div id=inv class=inventory></div>';
					e.innerHTML = html;

					// build item slots
					var slots_html ='';
					for(i = 1; i < 9; i++) {
						 slots_html += '<div id=inv_slot'+i+' class=inv_slot></div>';
					}
					document.getElementById("inv").innerHTML += slots_html;
					var html_item = '';
                // loop through the parsed array to find the objects
					for(var key in inv_array) {
						if(string.hasOwnProperty(key)) {
						// find the first key and parse it too, so that we can dig into the items actual data

							item = inv_array[key];
							id = item.ref;
							if(id && (m=id.match(/\[0x([0-9a-f]+)\]/i))) {
									id = parseInt(m[1],16);
								icon = '<img class=item atom='+id+'>';
								var bgurl = this.atomIcon(id);  // gets the atom's icon and makes a url for it
							}
							console.log(item);
							console.log(JSON.stringify(item));
							// add the item's properties into it's own div!
							html_item = '<div data-ref='+item.ref+' data-quality='+item.quality+' style=\'background-image: url('+bgurl+');\' class=item ></div>';
							var slot = 'inv_slot'+item.inv_position
							console.log(slot);
							document.getElementById(slot).innerHTML = html_item;
							}
					}

					// set the inventory output to the bags div
					//console.log(document.getElementById("inv").innerHTML);
					//document.getElementById("inv").innerHTML = html_items;

					// cycle through all the existing  .items and ensure there's a click listener
					a = e.querySelectorAll('.item');
					for(i=a.length; i--;) a[i].addEventListener('click', clickhandler); // adds the event click to the items and uses clickhandler function above

					// https://youtu.be/0sfPDJiMTXk
            }
        }
    };
})()
</script>


</byondclass>


</byondclass>lass>ript>


</byondclass>

</byondclass> the existing  .items and ensure there's a click listener
					a = e.querySelectorAll('.item');
					for(i=a.length; i--;) a[i].addEventListener('click', clickhandler); // adds the event click to the items and uses clickhandler function above

					// https://youtu.be/0sfPDJiMTXk
            }
        }
    };
})()
</script>


</byondclass>