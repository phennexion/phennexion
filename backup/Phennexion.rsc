�    �+�MW@;W�  dropboxes.dms <byondclass name="dropboxes">

<!-- Our CSS styling goes here -->

<style>
	#dropboxes {

	}
	.dropbox {
		position: absolute;
		width: 32px;
		height: 32px;
		display: block;
		outline: 2px dashed #ced3e7;
		top: 100px;
		left: 100px;
		opacity: 0.6;
	}
</style>

<!-- Our JavaScript code goes here -->
<script>
(function(){
	var dragSrc;
	function allowDrop(e) {
		e.preventDefault();
		return false;
	};
	function drop(e) {
		e.stopPropagation();

		this.innerHTML = e.dataTransfer.getData('text/html');
		var inside = document.getElementById(e.target.getAttribute("id")).firstChild;
		console.log(inside);

		// get vars of all the locations and slots
		var dragged_inv_ref = inside.getAttribute("data-ref");
		var drop_direction = e.target.getAttribute("data-dir");
		console.log("drop dir:"+drop_direction+"---ref:"+dragged_inv_ref+"--- innerHTML:"+this.innerHTML);
		// send command to byond client to change the inv_positions in user's inventory
		byond.fn.topic('action=dropitem;v1='+dragged_inv_ref+";v2="+drop_direction);

		var dropboxes = document.getElementById('dropboxes');
		dropboxes.innerHTML = '';

		return false;
	};
	return {
		fn: {

    output: function(obj,sub) {
      this.elem.innerHTML = obj.null ? '' : obj.text;


		// decode and fix up the json_encode'd list from the output
		var string = byond.htmlDecode(obj.text);
		var id, m, icon='';
		string = string.replace(/\n+$/,'');
		string = string.replace(/^\n+/,'');
		string = string.replace(/<br\s*\/?>/gi,'');

		//console.log(string);
		// make a new array that will parse the fixed up string from above
		var inv_array = JSON.parse(string);

		for(var key in inv_array) {
			if(string.hasOwnProperty(key)) {
			// find the first key and parse it too, so that we can dig into the items actual data

				item = inv_array[key];
				id = item.ref;
				//console.log("ref"+item.ref+"-loc:"+item.usrlocx+","+item.usrlocy+","+item.usrlocz+"-slot:"+item.slot);
				if(item.checkNorth == 0) {
					this.elem.innerHTML = "<div id=dropboxNorth data-dir=north class=dropbox></div>";
				}
				this.elem.innerHTML += "<div id=dropboxWest data-dir=west class=dropbox></div>";
				this.elem.innerHTML += "<div id=dropboxEast data-dir=east class=dropbox></div>";
				this.elem.innerHTML += "<div id=dropboxSouth data-dir=south class=dropbox></div>";
				var map = document.getElementById('map');
				map.style.width = window.innerWidth+'px';
				map.style.height = window.innerHeight+'px';
				console.log("map width:"+map.style.width + " window width:" + window.innerWidth + "window height:" + window.innerHeight)
				var midx = window.innerWidth/2
				var midy = window.innerHeight/2

				var dropboxNorth = document.getElementById('dropboxNorth');
				dropboxNorth.addEventListener('dragover', allowDrop);
				dropboxNorth.addEventListener('drop', drop);
				dropboxNorth.style.top = parseInt(midy-66)+'px';
				dropboxNorth.style.left = parseInt(midx)+'px';
				var dropboxWest = document.getElementById('dropboxWest');
				dropboxWest.addEventListener('dragover', allowDrop);
				dropboxWest.addEventListener('drop', drop);
				dropboxWest.style.top = parseInt(midy-34)+'px';
				dropboxWest.style.left = parseInt(midx-34)+'px';
				var dropboxEast = document.getElementById('dropboxEast');
				dropboxEast.addEventListener('dragover', allowDrop);
				dropboxEast.addEventListener('drop', drop);
				dropboxEast.style.top = parseInt(midy-34)+'px';
				dropboxEast.style.left = parseInt(midx+34)+'px';
				var dropboxSouth = document.getElementById('dropboxSouth');
				dropboxSouth.addEventListener('dragover', allowDrop);
				dropboxSouth.addEventListener('drop', drop);
				dropboxSouth.style.top = parseInt(midy+2)+'px';
				dropboxSouth.style.left = parseInt(midx)+'px';

			}
		}
    }
  }
    };
})()
</script>

<div id="content" class="content"></div>    <!-- The div that will be containing our text. -->
</byondclass>�   �Y���MW�vW�  first_byondclass.dms <byondclass name="firstclass">

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

</byondclass>�   ے��MWs�W�  index.dms <html>
<head>
<link href='https://fonts.googleapis.com/css?family=Play' rel='stylesheet' type='text/css'>
</head>
<body>
	<div id="main" byondclass="child" skinparams="left=map;fit=left;is-vert=true;">
		<div id="map" byondclass="map" skinparams="letterbox=true;zoom=1;"></div>
	</div>
	<div id="output" byondclass="output"></div>
	<div id="input" byondclass="input"></div>
	<div id="firstclass" byondclass="firstclass" skinparams="is-visible=false"></div>
	<div id="bags" byondclass="bags" skinparams="is-visible=true"></div>
	<div id="dropboxes" byondclass="dropboxes" skinparams="is-visible=true"></div>
</body>
</html>
<style>
	.byond_output {
		background-color: #000000;
		color: #fff;
		width: 400px;
	    height: 200px;
		font-family: 'Play', sans-serif;
	    position: absolute;
	    left: calc(85% - 400px/2);
	    top: calc(85% - 200px/2);
	    box-shadow: 0px 0px 10px #fff;
	    border-radius: 15px;
		color: #ced3e7;
	    padding: 15px;
	}
	Alternatively, you can use the selector #output. If you want to select a class, however, you always
	have to prefix it with "byond_".
	*/

</style>

macro
	T return "say"
macro
	I return "listInv"
macro
	O return "clearinv"�&   vw#��MW�>W�&  Inventory.dms <byondclass name="bags">

<!-- Our CSS styling goes here -->

<style>
	#bags {
	    width: 200px;
	    height: 300px;

	    position: absolute;
	    left: calc(90% - 200px/2);
	    top: calc(30% - 300px/2);
	}
	.item {
		width: 40px;
		height: 40px;

		background-size: 32px 32px;
		background-repeat: no-repeat;
		background-position: center center;
		display: inline-block;
	}
	.item:hover {
		-webkit-box-shadow: inset 2px -2px 14px 2px rgba(255,255,255,0.2);
		-moz-box-shadow: inset 2px -2px 14px 2px rgba(255,255,255,0.2);
		box-shadow: inset 2px -2px 14px 2px rgba(255,255,255,0.2);

	}
	.tooltip {
		padding-top: 16px;
		text-align: left;
		font-family: 'Play', sans-serif;
		font-size: 14px;
		width: 168px;
		height: 50px;
		display: inline-block;
		margin:0;
		vertical-align:top;
		color: #ced3e7;
		opacity: 0.94;
	}
	.inventory {
		width: 168px;
		height: 168px;
		display: inline-block;
		margin:0;
		vertical-align:top;
	}
	.inv_slot {
		width: 42px;
		height: 42px;
		flex-shrink: 0;
		display: inline-block;
		margin:0;
		vertical-align:top;
		background-image: url("slotbg.png");
	}
	.inv_header {
		display: inline-block;
		margin:0;
		vertical-align:top;
		width: 200px;
		height: 32px;
		background-image: url("inv_header.png");
	}
	.inv_toggle {
		display: inline-block;
		position: absolute;
		margin:0;
		vertical-align:top;
		width: 32px;
		height: 32px;
		left: 166px;
		background-image: url("inv_collapse.png");
		background-size: 32px 32px;
		background-repeat: no-repeat;
	}
	.inv_bg {
		padding-left:16px;
		padding-top:16px;
		display: inline-block;
		margin:0;
		vertical-align:top;
		width: 200px;
		height: 268px;
		background-image: url("inv_bg.png");
	}
	.text{
		background-image: url("inv_expand.png");

	}
	[draggable] {
	-moz-user-select: none;
	-khtml-user-select: none;
	-webkit-user-select: none;
	user-select: none;
	/* Required to make elements draggable in old WebKit */
	-khtml-user-drag: element;
	-webkit-user-drag: element;
	}
</style>

<!-- Our JavaScript code goes here -->
<script>
(function(){
	var dragSrc;
	var dragged_inv_ref;
	var offX, offY;

	function fixListeners() {
		var a, i;
		e = document.getElementById("inv");

		// cycle through all the existing  .items and .item_slots and ensure the drag listeners are set
		a = e.querySelectorAll('.item');
		for(i=a.length; i--;) a[i].addEventListener('mouseover', hover); // adds the event click to the items and uses clickhandler function above

		a = e.querySelectorAll('.inv_slot');
		for(i=a.length; i--;) a[i].addEventListener('drop', drop); // adds the event click to the items and uses clickhandler function above

		a = e.querySelectorAll('.inv_slot');
		for(i=a.length; i--;) a[i].addEventListener('dragover', allowDrop); // adds the event click to the items and uses clickhandler function above

		a = e.querySelectorAll('.inv_slot');
		for(i=a.length; i--;) a[i].addEventListener('dragstart', drag); // adds the event click to the items and uses clickhandler function above

		a = e.querySelectorAll('.inv_slot');
		for(i=a.length; i--;) a[i].addEventListener('dragend', dragEnd); // adds the event click to the items and uses clickhandler function above

		// set listeners on the rest of the bags to add drag functionality
		var inv_header_elem = document.getElementById('inv_header');
		var inv_toggle_elem = document.getElementById('inv_toggle');
		inv_header_elem.addEventListener('mousedown', dragBagsStart);
		inv_header_elem.addEventListener('mouseup', dragBagsStop);
		inv_toggle_elem.addEventListener('click', toggleInv);
		var inventory = document.getElementById('inv_bg');
		// ensure the collapse button is pointing the right way
		if(inventory.style.display !=='none'){
			document.getElementById('inv_toggle').style.backgroundImage = "url('inv_collapse.png')";
		}
		else
		{
			document.getElementById('inv_toggle').style.backgroundImage = "url('inv_expand.png')";
		}
	}
	function hover(e) { // hovering over an item to show info in the tooltip
		var tooltip = document.getElementById("tooltip");
		var name= '', quality='', ref='';
		name = e.target.getAttribute("data-name");
		quality = e.target.getAttribute("data-quality");
		ref = e.target.getAttribute("data-ref");

		tooltip.innerHTML = '<b>'+name+'</b><br><font size=-1>Quality : '+quality+'<br>Ref : '+ref+'</font>';
	}
	function toggleInv(e) {  // click the arrow on header to collapse and expand the inventory
		var inventory = document.getElementById('inv_bg');
		if(inventory.style.display !=='none'){
			inventory.style.display = 'none';
			document.getElementById('inv_toggle').style.backgroundImage = "url('inv_expand.png')";
		}
		else
		{
			inventory.style.display = 'inline-block';
			document.getElementById('inv_toggle').style.backgroundImage = "url('inv_collapse.png')";
		}

		console.log('drag target'+ e.target.getAttribute("class") + 'and this is ' +status);
		e.stopPropagation(); // stops handlers below in the DOM tree from triggering
		e.preventDefault();
	};
	function dragBagsStart(e) {  // is called when user clicks and drags the header

		dragSrc = this;

		var bags = document.getElementById("bags")
		console.log('drag target'+ e.target.getAttribute("class") + 'and this is ' +this);
		console.log('clientX' + e.clientX + '   clientY' + e.clientY);
		bags.style.position = 'absolute';
		offY= e.clientY-parseInt(bags.offsetTop);
		offX= e.clientX-parseInt(bags.offsetLeft);
		bags.addEventListener('mousemove', moveBags, true);
		e.stopPropagation();

	};
	function moveBags(e) { // is added to user's client when user starts dragging
		dragSrc = this;
		var bags = document.getElementById("bags")
		bags.style.position = 'absolute';
		bags.style.top = (e.clientY-offY) + 'px';
		bags.style.left = (e.clientX-offX) + 'px';
		e.stopPropagation();

	};

	function dragBagsStop(e) { // removes the moveBags when user lifts mouse button
		var bags = document.getElementById("bags")
		bags.removeEventListener('mousemove', moveBags, true);
		e.stopPropagation();

	};
	function drag(e) { // called when item is dragged
		// dragSrc will be the "previous slot"
		dragSrc = this;
		console.log('drag target'+ e.target.getAttribute("class") + 'and this is ' +this);
		byond.fn.topic("action=DropBox;v1="+e.target.getAttribute("data-ref")+";v2"+e.target.getAttribute("data-slot"));
		dragged_inv_ref = e.target.getAttribute("data-ref");
		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/html', this.innerHTML);
	};

	function drop(e) {
		e.stopPropagation();
		if (dragSrc != this) {
			dragSrc.innerHTML = this.innerHTML;
			this.innerHTML = e.dataTransfer.getData('text/html');

			// get vars of all the locations and slots
			var dragged_inv_position = this.getAttribute("data-slot");
			var replaced_inv_position = dragSrc.getAttribute("data-slot");
			var replaced_inv_ref = e.target.closest('div').getAttribute("data-ref");

			// send command to byond client to change the inv_positions in user's inventory
			byond.fn.topic('action=change_inv_slot;v1='+dragged_inv_ref+';v2'+dragged_inv_position);
			if(replaced_inv_ref==null){
				console.log("did not replace a slot");
			}
			if(replaced_inv_ref!=null){
				console.log("updating swapped inventory item");
				byond.fn.topic("action=change_inv_slot;v1="+replaced_inv_ref+";v2"+replaced_inv_position);
			}
			fixListeners();
			var dropboxes = document.getElementById('dropboxes');
			dropboxes.innerHTML = '';
		}
		return false;
	};
	function dragEnd(e) {

	};
	function allowDrop(e) {
		e.preventDefault();
		return false;
	};
    return {
        fn: {
            output: function(obj,sub) {  // the start of the output function from bags() proc
					var e = this.elem;


					// decode and fix up the json_encode'd list from the output
					var string = byond.htmlDecode(obj.text);
					var id, m, icon='';
					string = string.replace(/\n+$/,'');
					string = string.replace(/^\n+/,'');
					string = string.replace(/<br\s*\/?>/gi,'');


					// make a new array that will parse the fixed up string from above
					var inv_array = JSON.parse(string);

					// build the UI Divs
					var html = '';
					html = '<div id=inv_header class=inv_header><div id=inv_toggle class=inv_toggle></div></div>';
					html += '<div id=inv_bg class=inv_bg><div id=inv class=inventory></div><div id=tooltip class=tooltip></div></div>';
					e.innerHTML = html;

					// build item slots
					var slots_html ='';
					for(i = 1; i < 17; i++) {
						 slots_html += '<div id=inv_slot'+i+' data-slot=='+i+' class=inv_slot></div>';
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
							// add the item's properties into it's own div!
							html_item = '<div draggable=true data-ref='+item.ref+' data-name='+item.name+' data-quality='+item.quality+' data-imgsrc='+bgurl+' style=\'background-image: url('+bgurl+');\' class=item ></div>';
							var slot = 'inv_slot'+item.inv_position;
							// add the item to the slot
							document.getElementById(slot).innerHTML = html_item;
							}
					}

					fixListeners();
            }
        }
    };
})()
</script>


</byondclass>�Y  A,��MW�W�Y  slotbg.png �PNG

   IHDR   *   *   J�^   	pHYs     ��  
OiCCPPhotoshop ICC profile  xڝSgTS�=���BK���KoR RB���&*!	J�!��Q�EEȠ�����Q,�
��!���������{�kּ������>�����H3Q5��B�������.@�
$p �d!s�# �~<<+"�� x� �M��0���B�\���t�8K� @z�B� @F���&S � `�cb� P- `'�� ����{ [�!��  e�D h; ��V�E X0 fK�9 �- 0IWfH �� ���  0Q��) { `�##x �� F�W<�+��*  x��<�$9E�[-qWW.(�I+6aa�@.�y�2�4���  ������x����6��_-��"bb���ϫp@  �t~��,/��;�m��%�h^�u��f�@� ���W�p�~<<E���������J�B[a�W}�g�_�W�l�~<�����$�2]�G�����L�ϒ	�b��G�����"�Ib�X*�Qq�D���2�"�B�)�%��d��,�>�5 �j>{�-�]c�K'Xt���  �o��(�h���w��?�G�% �fI�q  ^D$.Tʳ?�  D��*�A��,�����`6�B$��BB
d�r`)��B(�Ͱ*`/�@4�Qh��p.�U�=p�a��(��	A�a!ڈb�X#����!�H�$ ɈQ"K�5H1R�T UH�=r9�\F��;� 2����G1���Q=��C��7�F��dt1�����r�=�6��Ыhڏ>C�0��3�l0.��B�8,	�c˱"����V����cϱw�E�	6wB aAHXLXN�H� $4�	7	�Q�'"��K�&���b21�XH,#��/{�C�7$�C2'��I��T��F�nR#�,��4H#���dk�9�, +ȅ����3��!�[
�b@q��S�(R�jJ��4�e�2AU��Rݨ�T5�ZB���R�Q��4u�9̓IK�����hh�i��t�ݕN��W���G���w��ǈg(�gw��L�Ӌ�T071���oUX*�*|��
�J�&�*/T����ުU�U�T��^S}�FU3S�	Ԗ�U��P�SSg�;���g�oT?�~Y��Y�L�OC�Q��_�� c�x,!k��u�5�&���|v*�����=���9C3J3W�R�f?�q��tN	�(���~���)�)�4L�1e\k����X�H�Q�G�6������E�Y��A�J'\'Gg����S�Sݧ
�M=:��.�k���Dw�n��^��Lo��y���}/�T�m���GX�$��<�5qo</���QC]�@C�a�a�ᄑ��<��F�F�i�\�$�m�mƣ&&!&KM�M�RM��)�;L;L���͢�֙5�=1�2��כ߷`ZxZ,����eI��Z�Yn�Z9Y�XUZ]�F���%ֻ�����N�N���gð�ɶ�����ۮ�m�}agbg�Ů��}�}��=���Z~s�r:V:ޚΜ�?}����/gX���3��)�i�S��Ggg�s�󈋉K��.�>.���Ƚ�Jt�q]�z���������ۯ�6�i�ܟ�4�)�Y3s���C�Q��?��0k߬~OCO�g��#/c/�W�װ��w��a�>�>r��>�<7�2�Y_�7��ȷ�O�o�_��C#�d�z�� ��%g��A�[��z|!��?:�e����A���AA�������!h�쐭!��Α�i�P~���a�a��~'���W�?�p�X�1�5w��Cs�D�D�Dޛg1O9�-J5*>�.j<�7�4�?�.fY��X�XIlK9.*�6nl��������{�/�]py�����.,:�@L�N8��A*��%�w%�
y��g"/�6ш�C\*N�H*Mz�쑼5y$�3�,幄'���LLݛ:��v m2=:�1����qB�!M��g�g�fvˬe����n��/��k���Y-
�B��TZ(�*�geWf�͉�9���+��̳�ې7�����ᒶ��KW-X潬j9�<qy�
�+�V�<���*m�O��W��~�&zMk�^�ʂ��k�U
�}����]OX/Yߵa���>������(�x��oʿ�ܔ���Ĺd�f�f���-�[����n�ڴ�V����E�/��(ۻ��C���<��e����;?T�T�T�T6��ݵa��n��{��4���[���>ɾ�UUM�f�e�I���?�������m]�Nmq����#�׹���=TR��+�G�����w-6U����#pDy���	��:�v�{���vg/jB��F�S��[b[�O�>����z�G��4<YyJ�T�i��ӓg�ό���}~.��`ۢ�{�c��jo�t��E���;�;�\�t���W�W��:_m�t�<���Oǻ�����\k��z��{f���7����y���՞9=ݽ�zo������~r'��˻�w'O�_�@�A�C݇�?[�����j�w����G��������C���ˆ��8>99�?r����C�d�&����ˮ/~�����јѡ�򗓿m|������������x31^�V���w�w��O�| (�h���SЧ��������c3-�  :iTXtXML:com.adobe.xmp     <?xpacket begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/" x:xmptk="Adobe XMP Core 5.5-c014 79.151481, 2013/03/13-12:09:15        ">
   <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
      <rdf:Description rdf:about=""
            xmlns:xmp="http://ns.adobe.com/xap/1.0/"
            xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/"
            xmlns:stEvt="http://ns.adobe.com/xap/1.0/sType/ResourceEvent#"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:photoshop="http://ns.adobe.com/photoshop/1.0/"
            xmlns:tiff="http://ns.adobe.com/tiff/1.0/"
            xmlns:exif="http://ns.adobe.com/exif/1.0/">
         <xmp:CreatorTool>Adobe Photoshop CC (Windows)</xmp:CreatorTool>
         <xmp:CreateDate>2016-04-15T19:06:36-06:00</xmp:CreateDate>
         <xmp:MetadataDate>2016-04-15T19:06:36-06:00</xmp:MetadataDate>
         <xmp:ModifyDate>2016-04-15T19:06:36-06:00</xmp:ModifyDate>
         <xmpMM:InstanceID>xmp.iid:4a9fece8-d4ef-ff4c-85c3-d2eecf18ef14</xmpMM:InstanceID>
         <xmpMM:DocumentID>xmp.did:bc51de2e-5a3a-4d42-aefb-c6a7ad662ffe</xmpMM:DocumentID>
         <xmpMM:OriginalDocumentID>xmp.did:bc51de2e-5a3a-4d42-aefb-c6a7ad662ffe</xmpMM:OriginalDocumentID>
         <xmpMM:History>
            <rdf:Seq>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>created</stEvt:action>
                  <stEvt:instanceID>xmp.iid:bc51de2e-5a3a-4d42-aefb-c6a7ad662ffe</stEvt:instanceID>
                  <stEvt:when>2016-04-15T19:06:36-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
               </rdf:li>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>saved</stEvt:action>
                  <stEvt:instanceID>xmp.iid:4a9fece8-d4ef-ff4c-85c3-d2eecf18ef14</stEvt:instanceID>
                  <stEvt:when>2016-04-15T19:06:36-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
                  <stEvt:changed>/</stEvt:changed>
               </rdf:li>
            </rdf:Seq>
         </xmpMM:History>
         <dc:format>image/png</dc:format>
         <photoshop:ColorMode>3</photoshop:ColorMode>
         <photoshop:ICCProfile>sRGB IEC61966-2.1</photoshop:ICCProfile>
         <tiff:Orientation>1</tiff:Orientation>
         <tiff:XResolution>720000/10000</tiff:XResolution>
         <tiff:YResolution>720000/10000</tiff:YResolution>
         <tiff:ResolutionUnit>2</tiff:ResolutionUnit>
         <exif:ColorSpace>1</exif:ColorSpace>
         <exif:PixelXDimension>42</exif:PixelXDimension>
         <exif:PixelYDimension>42</exif:PixelYDimension>
      </rdf:Description>
   </rdf:RDF>
</x:xmpmeta>
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                            
<?xpacket end="w"?>�{#�    cHRM  z%  ��  ��  ��  u0  �`  :�  o�_�F  �IDATx �)�=AU���	���
���     � �  ���  ��    �  ������������������   ��������� 
	������������	
������  ����� ���� �������     �   �� ����  ���������������  ����������
	������������  ��   ����  �	���
���   � � �� ���      	������� �������	
���� �����������������
� ������  �  ����������   �   � ��� ������ ���� ������ �������������� � ���������������	�������    ��    ��  �����������
���   ����������� ������  ����������� ������  � ����������� �������
������	

���   ���
	������
������	   ���������

���
���	������	  ������ �������� �� 

   ���������������� �
����  �  ������������������� ���
������   ���     ���������������������   

�������  ��� ���   ���������������   ������������������������ 			�������� ���  ��� ������   ���������   �����������


������
��������������  ������   ���������	���  ���� � �   ����� ��������� 
��������������� 	
	���� ���������������������  �   ������   ���   ��������� � ������������   ������	
����� ��������� ��   ���   ���   ���������������������
���   ������      ������������		���������    ������   ���	      ������			   	
 ������������ ��    ��      ���   ������������� �������   ���������������   ������		
����� ������	����� 
$#1���  
	
������	��������������������������� ������������		
���������� 
������ ���	  ���   ������������   ���������������   ������   ������������	)������������ ����� �����  ���������������      ���	������������������������"$0������  ������		


������������   	������������ ����� ������������������������ �������		������
��� ������   ������������
�������������������������������

���������������		���������	������� �������������  ������
 ���������������
������#
���		������������������   ���	������������ �����������������������	 �����
	������������������	 ���
������������������������  �      		   ������������������   ������   ������������   ������������   ���        
	���			�  ���		���   ���� �������������������   ������������   ���
����������	������  ������ �����������	
 ����� ����� �������������������    ����	�����������  ��������� ����� ������������������� 


  �� ���������  ��� ���  �� �   ��� 	
������� �  ����#	���������������������		
������  �� ��   ���  �����  ���������������   ���  ��������   ������	������������������������� ����       	
���  �   ���� ��� �������������   ��������������� ���������		������
���������#*+8���� 	
   ��   ���
���������������������  ����������   ��� ������ ��������� ��������  �	������������������������������   ������������     � �	
� �������    ������ ����   ������������		�� ����� ������ � ������  ��� ���   ����     � �       � �  �������  	���  ��������  		������������   ������ ���  ����  �� �
���     
	���������	
���������	���

��������� 	��� ���
��� ����
		
� � �������� ��������	

     ���  	�� ������� �� �������   
	
  
������	��������� ���  ��� ��������� �������������� � ����� � �
����� ��������������������������  �����������

���������������������

������ ��

  ��  �������	
	���������������������������  ���   	 	

���  � � ���������   �������������������������� � �� ������ ���
���� �������''5������	   ���
���		������� ���� ������*����ȵ	���
+,=������(*6&������������  ���S(k!l�d    IEND�B`��  <�7��MW_�W�  inv_header.png �PNG

   IHDR   �       �-�&   	pHYs     ��  
OiCCPPhotoshop ICC profile  xڝSgTS�=���BK���KoR RB���&*!	J�!��Q�EEȠ�����Q,�
��!���������{�kּ������>�����H3Q5��B�������.@�
$p �d!s�# �~<<+"�� x� �M��0���B�\���t�8K� @z�B� @F���&S � `�cb� P- `'�� ����{ [�!��  e�D h; ��V�E X0 fK�9 �- 0IWfH �� ���  0Q��) { `�##x �� F�W<�+��*  x��<�$9E�[-qWW.(�I+6aa�@.�y�2�4���  ������x����6��_-��"bb���ϫp@  �t~��,/��;�m��%�h^�u��f�@� ���W�p�~<<E���������J�B[a�W}�g�_�W�l�~<�����$�2]�G�����L�ϒ	�b��G�����"�Ib�X*�Qq�D���2�"�B�)�%��d��,�>�5 �j>{�-�]c�K'Xt���  �o��(�h���w��?�G�% �fI�q  ^D$.Tʳ?�  D��*�A��,�����`6�B$��BB
d�r`)��B(�Ͱ*`/�@4�Qh��p.�U�=p�a��(��	A�a!ڈb�X#����!�H�$ ɈQ"K�5H1R�T UH�=r9�\F��;� 2����G1���Q=��C��7�F��dt1�����r�=�6��Ыhڏ>C�0��3�l0.��B�8,	�c˱"����V����cϱw�E�	6wB aAHXLXN�H� $4�	7	�Q�'"��K�&���b21�XH,#��/{�C�7$�C2'��I��T��F�nR#�,��4H#���dk�9�, +ȅ����3��!�[
�b@q��S�(R�jJ��4�e�2AU��Rݨ�T5�ZB���R�Q��4u�9̓IK�����hh�i��t�ݕN��W���G���w��ǈg(�gw��L�Ӌ�T071���oUX*�*|��
�J�&�*/T����ުU�U�T��^S}�FU3S�	Ԗ�U��P�SSg�;���g�oT?�~Y��Y�L�OC�Q��_�� c�x,!k��u�5�&���|v*�����=���9C3J3W�R�f?�q��tN	�(���~���)�)�4L�1e\k����X�H�Q�G�6������E�Y��A�J'\'Gg����S�Sݧ
�M=:��.�k���Dw�n��^��Lo��y���}/�T�m���GX�$��<�5qo</���QC]�@C�a�a�ᄑ��<��F�F�i�\�$�m�mƣ&&!&KM�M�RM��)�;L;L���͢�֙5�=1�2��כ߷`ZxZ,����eI��Z�Yn�Z9Y�XUZ]�F���%ֻ�����N�N���gð�ɶ�����ۮ�m�}agbg�Ů��}�}��=���Z~s�r:V:ޚΜ�?}����/gX���3��)�i�S��Ggg�s�󈋉K��.�>.���Ƚ�Jt�q]�z���������ۯ�6�i�ܟ�4�)�Y3s���C�Q��?��0k߬~OCO�g��#/c/�W�װ��w��a�>�>r��>�<7�2�Y_�7��ȷ�O�o�_��C#�d�z�� ��%g��A�[��z|!��?:�e����A���AA�������!h�쐭!��Α�i�P~���a�a��~'���W�?�p�X�1�5w��Cs�D�D�Dޛg1O9�-J5*>�.j<�7�4�?�.fY��X�XIlK9.*�6nl��������{�/�]py�����.,:�@L�N8��A*��%�w%�
y��g"/�6ш�C\*N�H*Mz�쑼5y$�3�,幄'���LLݛ:��v m2=:�1����qB�!M��g�g�fvˬe����n��/��k���Y-
�B��TZ(�*�geWf�͉�9���+��̳�ې7�����ᒶ��KW-X潬j9�<qy�
�+�V�<���*m�O��W��~�&zMk�^�ʂ��k�U
�}����]OX/Yߵa���>������(�x��oʿ�ܔ���Ĺd�f�f���-�[����n�ڴ�V����E�/��(ۻ��C���<��e����;?T�T�T�T6��ݵa��n��{��4���[���>ɾ�UUM�f�e�I���?�������m]�Nmq����#�׹���=TR��+�G�����w-6U����#pDy���	��:�v�{���vg/jB��F�S��[b[�O�>����z�G��4<YyJ�T�i��ӓg�ό���}~.��`ۢ�{�c��jo�t��E���;�;�\�t���W�W��:_m�t�<���Oǻ�����\k��z��{f���7����y���՞9=ݽ�zo������~r'��˻�w'O�_�@�A�C݇�?[�����j�w����G��������C���ˆ��8>99�?r����C�d�&����ˮ/~�����јѡ�򗓿m|������������x31^�V���w�w��O�| (�h���SЧ��������c3-�  :�iTXtXML:com.adobe.xmp     <?xpacket begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/" x:xmptk="Adobe XMP Core 5.5-c014 79.151481, 2013/03/13-12:09:15        ">
   <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
      <rdf:Description rdf:about=""
            xmlns:xmp="http://ns.adobe.com/xap/1.0/"
            xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/"
            xmlns:stEvt="http://ns.adobe.com/xap/1.0/sType/ResourceEvent#"
            xmlns:photoshop="http://ns.adobe.com/photoshop/1.0/"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:tiff="http://ns.adobe.com/tiff/1.0/"
            xmlns:exif="http://ns.adobe.com/exif/1.0/">
         <xmp:CreatorTool>Adobe Photoshop CC (Windows)</xmp:CreatorTool>
         <xmp:CreateDate>2016-04-17T08:19:10-06:00</xmp:CreateDate>
         <xmp:MetadataDate>2016-04-17T08:19:10-06:00</xmp:MetadataDate>
         <xmp:ModifyDate>2016-04-17T08:19:10-06:00</xmp:ModifyDate>
         <xmpMM:InstanceID>xmp.iid:f8b8ca62-f9eb-f147-950c-0999a05a66a0</xmpMM:InstanceID>
         <xmpMM:DocumentID>xmp.did:39305f36-ee19-f543-b7d9-7d606a712950</xmpMM:DocumentID>
         <xmpMM:OriginalDocumentID>xmp.did:39305f36-ee19-f543-b7d9-7d606a712950</xmpMM:OriginalDocumentID>
         <xmpMM:History>
            <rdf:Seq>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>created</stEvt:action>
                  <stEvt:instanceID>xmp.iid:39305f36-ee19-f543-b7d9-7d606a712950</stEvt:instanceID>
                  <stEvt:when>2016-04-17T08:19:10-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
               </rdf:li>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>saved</stEvt:action>
                  <stEvt:instanceID>xmp.iid:f8b8ca62-f9eb-f147-950c-0999a05a66a0</stEvt:instanceID>
                  <stEvt:when>2016-04-17T08:19:10-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
                  <stEvt:changed>/</stEvt:changed>
               </rdf:li>
            </rdf:Seq>
         </xmpMM:History>
         <photoshop:DocumentAncestors>
            <rdf:Bag>
               <rdf:li>xmp.did:830a7965-f391-9a4c-96c0-9365cc3820b9</rdf:li>
            </rdf:Bag>
         </photoshop:DocumentAncestors>
         <photoshop:ColorMode>3</photoshop:ColorMode>
         <photoshop:ICCProfile>sRGB IEC61966-2.1</photoshop:ICCProfile>
         <dc:format>image/png</dc:format>
         <tiff:Orientation>1</tiff:Orientation>
         <tiff:XResolution>720000/10000</tiff:XResolution>
         <tiff:YResolution>720000/10000</tiff:YResolution>
         <tiff:ResolutionUnit>2</tiff:ResolutionUnit>
         <exif:ColorSpace>1</exif:ColorSpace>
         <exif:PixelXDimension>200</exif:PixelXDimension>
         <exif:PixelYDimension>32</exif:PixelYDimension>
      </rdf:Description>
   </rdf:RDF>
</x:xmpmeta>
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                            
<?xpacket end="w"?>4�v^    cHRM  z%  ��  ��  ��  u0  �`  :�  o�_�F  K0IDATx  Kߴ13D������������	���������   	���������������������   ��� !1���   	���   ������      ���	������&������

���������������   		   
���������	��������� !-������������ 	
���	������   ���      ���������
������   ���������
���      #   ������������������   ������	   	���������������������������   		!������������	���������������������������	������������		������������������������24E������	 �������

������������   	
���������

���         � ����������������   ���   ������         
 ���������������	���   ������������������   ������		���
	������   	
������������	���			������	���������   ������������   ���	���


���
������������������������%������	
������������� ����   ������������������   �������������������  ������ �����������		  �� ����	
��� ���������������������	
������ ������
	
���    � ������ ��		
��� �� ������������������������������������������������������������� ����������������������������������� �	
���������	����������� ������������  
	������������ ����� �������� �  �  ������� ������������   ���� 	������	������������������ � ������������
	���������  ������� 
������

  ���� 
		������������ ����  � ��


������	

������������� �����  	������  ������� ����������������������������������  &������ ������������	������������ ��   �   �������� �������������

 ���  �������������������� ����   ���

������	���� ���������� � ������       �������������� ����� ������������ ������������������  ���	������� � ����������������������������� ���������� �������� ������� ���������� 	������������������	
����������������������������������� 		���� ����  �	
������������		
������		  ��������������������  �� ������ ���������  	�� � �������  �������������������������� ������������������� �������������������  		��������� �������   


���������������������
  �������������   ������ � ���	���
 ��������� ������ �  ���  ������	 ���� 		������  ���    �������������� ������������������������������������������������������������ ����� ���������������������������	
���   �������� ������ ���		������������� �     ���������������   ���				������  ���  �    ������	

������������  �  ����� 

	
������   ���  �������������������  ������		   ������������������������ ��������� �����������    ���� �	� �� ����			  ������������������������
������������������������������������������
������   ����������  ���  ��������� �����������������������������������  ���������
	������	���������������

������������������ ��
��� � ������ ������������������
���������

 ���������  ����������������������������������������  ������  �
	����� ������������������������ �������������

� ������������������������������������������   ��� 	
���������  ���������
���������������������������������� ������������������	���    ���������� �������������� 		 �����������������������������������������������������������      ������������������������������������������   ������������������� � ��� ����� ���    ���������������������	
������������		��� � ���������������������������������
������   

������������ "$/������ ��������� �� �	
��������� �������������������	���� ��� ����������� ���  ��������������������������� ��������������	���		   ������   ��� ���������������������������������   ������������������	    � ���������������
���������������������������������������	������		
������������ ���
��� ���	
	

������� ����������		���������������	���	���	��������������������������� �������� �����  	
 (��� ������������� ��� � �����   ������������������������������������
������	   ������������������������ � ������� �  	������������������������������������������������
	�������    � ������� ��������� ����������� �����			������ ����������������� ����������������� ������		
������

������������������������������  ��� � � ������� ������		��� �� �����		���������  ��������������������������������������������������� ������  ���  �������������   ���wvs��������� � 
   ��� ���	
�������������� ���    ��
	������������ � � ����������������   � �	
��� �� 
	���
�������������������������   ���		��������  ����  ����  	���  ��������������	
	������
		 		������������������������

���  ������������   ���   ���	
�������� ���������	���������������������      ���  ���         ������������		
���    ������		�������� ����� ������   	���  ���� �         ����������������	���	���	������������� �   ���������	��� ��������������� �������   ������RRS68;   ��玌�    	��� � ����������������� ��  ���� �����������	
��� ��  ����  ����������

������� ���������	���������	���������������   	 � ������   ������  ������������������������   ���������������	
���������			      ��������������   ���������������������������� ��

          ������������������������  �����������������  ���������������������������������      ���������   ���	*,.003   ���������������  �������   ���		���������	������� ��    ���� �������� ������������ � ������   ��������
������    ��   	
������������   	
���������   
���

���	��� ���	
������      ���	
����������������������������	   ������      ��   �������   ������������������������������
������ ������
� �      ������   ������113      �����Ã�{@@Az|�   ���sqi���;<:z|�   ���SQJ(('_ag..1      ������xws ���   ������113      �����Ą�~]^_VW\          ���   ������!"^_f..1         �����ß����􀂄002   ���������002   ���VUO���,-/   ���jif������      ���   ������
�����������   ������������	
���
���������������������	���������  � �   ������ �����������������������������������   ������������	������������	
���������	
����� ���		������������   ��������         ������      ���������==@QRT������   GIL���HJO      ����� ���114���������114��� ���      ���������<<?RRS���������      ���������������~�114������������ WW]>>>���      003��������բ�����   ('&� ����      ������������������ ��  ������������   ���������������	���   ���������   ���   ���
	���������         ������ ������������������������	
   ��������� ���������������������   ������������   ��������� ������ ���������	��� ������  �      �  	
���         rrq������'(+   ,,0������!   225 ���'&(   ������RST   ���vtn���	���         mli���������)),   )+.������y|   ���zyt    NNO   ���kjc���~��==@   IJN���         ���ooi������&&)   JLPٌ�    ���������       �����������	
 ��	���������������������   ���      ������ ���������   ������������   �����
���������
   ������������������   ������
   ���������   ���	������	
	
������
������������� ����  ���	���            ���         ��������      ���KKP%&#���   ������<=B      
������   		         ���	������       �� ����            ���        ���������  �               ���  � �������&&)   114
LMM   ��� ������� �  ��� ����� ��
���������������������������   ������   ������		���   ������������������������         				���������   �����   ���������
	�����
	���      ������������������
	�������   ������������   ���������	
         ���         ������          ������   GINbcj      ���      336114336      ������         ������           ���            ������         ���������            ���  �        � ������������      657   ������  ����	   ���   ���������������������������	
���   ������	
	
���������������������	
�� ������
   ���������   ���������		
   ������������   ������������     ������������	
���   ���������         ���   ������������             ���         ���	���             ����:;?**,   ������ �       ���XVO   ���           � ����           ���  �         	         �  ������ �          ������        		���������::=]^^$%'   ���	����      �����������������   	���   ���� ���������� �����      ������
� �����	���������   ���   ������
����   �������������������������     ���	��� ����            ���   ����  �������� ��������   ������ � ������ ��
         ������� �                  ���������      ������      
���������          � ���      
 ���         ���      ���  � �        ���          ���������������   669

   ���	���������  � �������            ���	������   ���      ������������
 �����������   	
   ���������		
������������      ���������������	
    �����   	
	
���     �   ������   	�������  ���� �  ������      ���            �            ���ddi   ������������NOS������  � � � �kjf            ������      
���JJO   ��   ������XY\���      **-      ���           ���� �����    �� ���-.1   ������	������������    
���������  ��������   ���      ������������	���   ���������������������
���������	
��������    ������������� ������	

���  � �� ���   ������
���   ���������   ����  �   ������������������������          �          �����	        ���������TTX   ���������wul_ag..1         ������ ��         �����             ��������˪��KLQ114   ���������KLR114114         ���������      ���    ������-.1      ���

��� ���������
���
  ��������������������������� ��   ���	�����  ����  �������	
������   			���  ����������  ������  �����������	   ������	���      ������������   ����������	���	
������ !.���
������� ������  ������	��� �����������         ���  ������  ������	��� ������������������       	
������ � �������      ������    �����  ��   	������ ��� ��������]\[�� ���		
���������  ������������   ���   	���������������   ���   	������������������	      ���      ������	���������������   	���������      ���   ���   ���������������  ���    ���������

����  	��� �� � ������   �������
���  ������� 
���������  �� ��������������������	������  �������� �������		 ������	
   VWU   ������������������	
������   ������������������������������������   
������  �   ���   ���   ���� �    ������
      ��������������������   ���������������   ���   ��� ���	���   ��������� 
	

������    ������    �����
���  ��� ������������   ������� ���� �   ����� ��� ���������	   ��������������  ���   ���� �������������   ������ 	
���   ������   ������  �	���������FFJ      ��������� ��� �� � �������� � �����������	�������  ���   ���      ������   ���   ���	�����	������������������������������������      ����������������� ���   ���     �������		������    �� ����������� �������� ���������������������������������������������   �� ������������� ���
���    �������    ����
���������
������������ ����������� ���		������  mnn)),   ��㘘����
��� ������	
   	������������������������������  ���� �������
������������� �		���������������������������������
������ � ��������� �  �   �������  ���������������������������������
����$&3�������  ����� ������		������	������ �����	������ ����������    ���   ���      	���   ���������������  ����   ���   ���      ���
������   ��� ������������   ������

���� ���������������   ���������	���  ���	���������   ���   ���
    ������������
	
������������   ���������	���
���������      ���   ������������   ���������            	���   ���   		���������   ������     ����������)�����������	���  �������� ������������  � ���������  ���  

��� � ������� ����	�����  ���������� ������������� ���  �  ������ ���  �  ������������ ���  ������������� ��������������������� ���     �������� ���������������������		
� � ���������   ������
	���������������������������������� ����������	
���	���� � 
    ������� ��  �

���	������������   ���		��� ��� ������  ���������������� ���� �� �    ���  ��������������������������� ������ � 	������	������
������������� ����   ��   ���  � ���
��� �  ����

������	���
   

  � �������� �	������������������	  ������������� �
��� ������������  ���������������  �������������������������  ��������� ��   	������	
 ������
 � ���������  �������� ���
	������� �	���� � ������ ���	���	���� �   ��� ����� 	��� ���������������      �������� �� ������  ��������    ���  ����
���   � � 	��������� �����������������   ������
�����������������  	���

  ���     ���������������	������������ ��� ����� �����������   ������ �� �����������������  ����   	������   ������		���	��������������
���   �� ����������    ������� ���������  ���     	
���    ������� ��� �
� �������������������  ���
���	 ������������   ���  ����  �   ������� ��������������� � ���  ������ ���������������  �������������   ������   ������  ������� �����������������������������������������  	���   ��������� �� � � �

���    ����� ��������  ���������������������������������������������������	
   ���   ����� �������������	���!+ � ��� � � � �	
	  ���
��� ����������
���	
������ ��  ���� ������     ����������� ���	���	������������������������   ���	������������������ �������� ��   ���������	��������	������������ ��� �������������    ������� ���������������   ������������ ������ ����� ���� ������ ���
	������� �      ���� �  �	���������     �� 	��������� 	


���������   ��r`߆͟�    IEND�B`�R  �<�	�MWJ�W�Q  inv_collapse.png �PNG

   IHDR           ���   	pHYs     ��  
OiCCPPhotoshop ICC profile  xڝSgTS�=���BK���KoR RB���&*!	J�!��Q�EEȠ�����Q,�
��!���������{�kּ������>�����H3Q5��B�������.@�
$p �d!s�# �~<<+"�� x� �M��0���B�\���t�8K� @z�B� @F���&S � `�cb� P- `'�� ����{ [�!��  e�D h; ��V�E X0 fK�9 �- 0IWfH �� ���  0Q��) { `�##x �� F�W<�+��*  x��<�$9E�[-qWW.(�I+6aa�@.�y�2�4���  ������x����6��_-��"bb���ϫp@  �t~��,/��;�m��%�h^�u��f�@� ���W�p�~<<E���������J�B[a�W}�g�_�W�l�~<�����$�2]�G�����L�ϒ	�b��G�����"�Ib�X*�Qq�D���2�"�B�)�%��d��,�>�5 �j>{�-�]c�K'Xt���  �o��(�h���w��?�G�% �fI�q  ^D$.Tʳ?�  D��*�A��,�����`6�B$��BB
d�r`)��B(�Ͱ*`/�@4�Qh��p.�U�=p�a��(��	A�a!ڈb�X#����!�H�$ ɈQ"K�5H1R�T UH�=r9�\F��;� 2����G1���Q=��C��7�F��dt1�����r�=�6��Ыhڏ>C�0��3�l0.��B�8,	�c˱"����V����cϱw�E�	6wB aAHXLXN�H� $4�	7	�Q�'"��K�&���b21�XH,#��/{�C�7$�C2'��I��T��F�nR#�,��4H#���dk�9�, +ȅ����3��!�[
�b@q��S�(R�jJ��4�e�2AU��Rݨ�T5�ZB���R�Q��4u�9̓IK�����hh�i��t�ݕN��W���G���w��ǈg(�gw��L�Ӌ�T071���oUX*�*|��
�J�&�*/T����ުU�U�T��^S}�FU3S�	Ԗ�U��P�SSg�;���g�oT?�~Y��Y�L�OC�Q��_�� c�x,!k��u�5�&���|v*�����=���9C3J3W�R�f?�q��tN	�(���~���)�)�4L�1e\k����X�H�Q�G�6������E�Y��A�J'\'Gg����S�Sݧ
�M=:��.�k���Dw�n��^��Lo��y���}/�T�m���GX�$��<�5qo</���QC]�@C�a�a�ᄑ��<��F�F�i�\�$�m�mƣ&&!&KM�M�RM��)�;L;L���͢�֙5�=1�2��כ߷`ZxZ,����eI��Z�Yn�Z9Y�XUZ]�F���%ֻ�����N�N���gð�ɶ�����ۮ�m�}agbg�Ů��}�}��=���Z~s�r:V:ޚΜ�?}����/gX���3��)�i�S��Ggg�s�󈋉K��.�>.���Ƚ�Jt�q]�z���������ۯ�6�i�ܟ�4�)�Y3s���C�Q��?��0k߬~OCO�g��#/c/�W�װ��w��a�>�>r��>�<7�2�Y_�7��ȷ�O�o�_��C#�d�z�� ��%g��A�[��z|!��?:�e����A���AA�������!h�쐭!��Α�i�P~���a�a��~'���W�?�p�X�1�5w��Cs�D�D�Dޛg1O9�-J5*>�.j<�7�4�?�.fY��X�XIlK9.*�6nl��������{�/�]py�����.,:�@L�N8��A*��%�w%�
y��g"/�6ш�C\*N�H*Mz�쑼5y$�3�,幄'���LLݛ:��v m2=:�1����qB�!M��g�g�fvˬe����n��/��k���Y-
�B��TZ(�*�geWf�͉�9���+��̳�ې7�����ᒶ��KW-X潬j9�<qy�
�+�V�<���*m�O��W��~�&zMk�^�ʂ��k�U
�}����]OX/Yߵa���>������(�x��oʿ�ܔ���Ĺd�f�f���-�[����n�ڴ�V����E�/��(ۻ��C���<��e����;?T�T�T�T6��ݵa��n��{��4���[���>ɾ�UUM�f�e�I���?�������m]�Nmq����#�׹���=TR��+�G�����w-6U����#pDy���	��:�v�{���vg/jB��F�S��[b[�O�>����z�G��4<YyJ�T�i��ӓg�ό���}~.��`ۢ�{�c��jo�t��E���;�;�\�t���W�W��:_m�t�<���Oǻ�����\k��z��{f���7����y���՞9=ݽ�zo������~r'��˻�w'O�_�@�A�C݇�?[�����j�w����G��������C���ˆ��8>99�?r����C�d�&����ˮ/~�����јѡ�򗓿m|������������x31^�V���w�w��O�| (�h���SЧ��������c3-�  :�iTXtXML:com.adobe.xmp     <?xpacket begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/" x:xmptk="Adobe XMP Core 5.5-c014 79.151481, 2013/03/13-12:09:15        ">
   <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
      <rdf:Description rdf:about=""
            xmlns:xmp="http://ns.adobe.com/xap/1.0/"
            xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/"
            xmlns:stEvt="http://ns.adobe.com/xap/1.0/sType/ResourceEvent#"
            xmlns:photoshop="http://ns.adobe.com/photoshop/1.0/"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:tiff="http://ns.adobe.com/tiff/1.0/"
            xmlns:exif="http://ns.adobe.com/exif/1.0/">
         <xmp:CreatorTool>Adobe Photoshop CC (Windows)</xmp:CreatorTool>
         <xmp:CreateDate>2016-04-17T08:14:32-06:00</xmp:CreateDate>
         <xmp:MetadataDate>2016-04-17T08:14:32-06:00</xmp:MetadataDate>
         <xmp:ModifyDate>2016-04-17T08:14:32-06:00</xmp:ModifyDate>
         <xmpMM:InstanceID>xmp.iid:e68245ab-8a71-2c46-83b0-42690ac7e596</xmpMM:InstanceID>
         <xmpMM:DocumentID>xmp.did:fabaf7db-0864-4540-8da3-e6171b694839</xmpMM:DocumentID>
         <xmpMM:OriginalDocumentID>xmp.did:fabaf7db-0864-4540-8da3-e6171b694839</xmpMM:OriginalDocumentID>
         <xmpMM:History>
            <rdf:Seq>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>created</stEvt:action>
                  <stEvt:instanceID>xmp.iid:fabaf7db-0864-4540-8da3-e6171b694839</stEvt:instanceID>
                  <stEvt:when>2016-04-17T08:14:32-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
               </rdf:li>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>saved</stEvt:action>
                  <stEvt:instanceID>xmp.iid:e68245ab-8a71-2c46-83b0-42690ac7e596</stEvt:instanceID>
                  <stEvt:when>2016-04-17T08:14:32-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
                  <stEvt:changed>/</stEvt:changed>
               </rdf:li>
            </rdf:Seq>
         </xmpMM:History>
         <photoshop:DocumentAncestors>
            <rdf:Bag>
               <rdf:li>xmp.did:830a7965-f391-9a4c-96c0-9365cc3820b9</rdf:li>
            </rdf:Bag>
         </photoshop:DocumentAncestors>
         <photoshop:ColorMode>3</photoshop:ColorMode>
         <photoshop:ICCProfile>sRGB IEC61966-2.1</photoshop:ICCProfile>
         <dc:format>image/png</dc:format>
         <tiff:Orientation>1</tiff:Orientation>
         <tiff:XResolution>720000/10000</tiff:XResolution>
         <tiff:YResolution>720000/10000</tiff:YResolution>
         <tiff:ResolutionUnit>2</tiff:ResolutionUnit>
         <exif:ColorSpace>1</exif:ColorSpace>
         <exif:PixelXDimension>32</exif:PixelXDimension>
         <exif:PixelYDimension>32</exif:PixelYDimension>
      </rdf:Description>
   </rdf:RDF>
</x:xmpmeta>
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                            
<?xpacket end="w"?>�M��    cHRM  z%  ��  ��  ��  u0  �`  :�  o�_�F  0IDATx  ��I
		��	�� � ��    ������������������������������������������������� �   ����������������������� ��������������
$������ 	����  		������ �� �� ���� �  ���������������������	�������$�  �  ���	���
��   ���	
���     ���������������������������������������  �����   
� ������� ������  ������ ������������������������	��� ��������������������� ��������������� �����������������		 � �  ��� ��
����������� � ��������� 	����������������������� ������	������  �	 �����   �  )M&���������  ��������������������� 
$# ���� �����+	\K2�	�
=F0$�������� ��������
��� ������� )� �� ���
  ����� 2XH3�����������d\4��������������� 
��� ��������������&� ��  ���
������ ,S?(��������� ������A0������ ������	��� ���� ����!
�������  �������� �  ZA(������ ��

������� D'����������� � ��������� �  ���������� �	���	:UI,������
 FM.%)������������8(���
���
� ��������� .��� � !Q8������
@7".����������������[2������� ���  ���  ���  !	����� (T,������� 	R?'2��������;		����������	@)
�����������
��� ���:	   $P4������S39���������	B)���
  ������B����������   ���������5�����  G���������\@%�������  �������	&���������	1�����������   �������     ,���� �	X1-���������   �� �������3QK,����,���������	     
 �������� �� =&K,#	����������� HD('$�������-"$*0����������   ��  ���� ��� �  ������e.%����������� GB'@ 
#����������.�������������     ����� 7���  ���<9��뮼����	A;"=
������H�����������	�������������������� ��   ��� �	 �3`<����� � B7>	������������b������������M2������
��� �� 	 ' 
���� �g$������L6A ������������������k�����������d����������  �� �� �������� S���M%����������������� ������, �+*���������I	����� 
������  ��   �� ���2	��@
6����� ������ ���	���������`$���6������������������  	 0    �� %
-������ ���   ��     ���	���
)7	�����������   	������+���   �      ���   ���   	 ����� ���   

�������       ����  3����� �     �� 
�� �� ����� �� �� �� �� �� ����� ����  �  	���  ��    �  
 ����� � �  �  �  �� ����������  �� ���   �  �� 	����  �   � ������ ����� ����    ���"������� ���   �  ������  � �� 	 ��  ��     �    �� �� �  ��    ����� ������  
 ���   �� �  �  �   �� 
  �� �� �  �� �  �  �� �  �  	 ����� ����       �����  �       	�� �   ��   ���X�8-њ�    IEND�B`�]� �"wM�MW5RWA� inv_bg.png �PNG

   IHDR   �     4n�   	pHYs     ��  
OiCCPPhotoshop ICC profile  xڝSgTS�=���BK���KoR RB���&*!	J�!��Q�EEȠ�����Q,�
��!���������{�kּ������>�����H3Q5��B�������.@�
$p �d!s�# �~<<+"�� x� �M��0���B�\���t�8K� @z�B� @F���&S � `�cb� P- `'�� ����{ [�!��  e�D h; ��V�E X0 fK�9 �- 0IWfH �� ���  0Q��) { `�##x �� F�W<�+��*  x��<�$9E�[-qWW.(�I+6aa�@.�y�2�4���  ������x����6��_-��"bb���ϫp@  �t~��,/��;�m��%�h^�u��f�@� ���W�p�~<<E���������J�B[a�W}�g�_�W�l�~<�����$�2]�G�����L�ϒ	�b��G�����"�Ib�X*�Qq�D���2�"�B�)�%��d��,�>�5 �j>{�-�]c�K'Xt���  �o��(�h���w��?�G�% �fI�q  ^D$.Tʳ?�  D��*�A��,�����`6�B$��BB
d�r`)��B(�Ͱ*`/�@4�Qh��p.�U�=p�a��(��	A�a!ڈb�X#����!�H�$ ɈQ"K�5H1R�T UH�=r9�\F��;� 2����G1���Q=��C��7�F��dt1�����r�=�6��Ыhڏ>C�0��3�l0.��B�8,	�c˱"����V����cϱw�E�	6wB aAHXLXN�H� $4�	7	�Q�'"��K�&���b21�XH,#��/{�C�7$�C2'��I��T��F�nR#�,��4H#���dk�9�, +ȅ����3��!�[
�b@q��S�(R�jJ��4�e�2AU��Rݨ�T5�ZB���R�Q��4u�9̓IK�����hh�i��t�ݕN��W���G���w��ǈg(�gw��L�Ӌ�T071���oUX*�*|��
�J�&�*/T����ުU�U�T��^S}�FU3S�	Ԗ�U��P�SSg�;���g�oT?�~Y��Y�L�OC�Q��_�� c�x,!k��u�5�&���|v*�����=���9C3J3W�R�f?�q��tN	�(���~���)�)�4L�1e\k����X�H�Q�G�6������E�Y��A�J'\'Gg����S�Sݧ
�M=:��.�k���Dw�n��^��Lo��y���}/�T�m���GX�$��<�5qo</���QC]�@C�a�a�ᄑ��<��F�F�i�\�$�m�mƣ&&!&KM�M�RM��)�;L;L���͢�֙5�=1�2��כ߷`ZxZ,����eI��Z�Yn�Z9Y�XUZ]�F���%ֻ�����N�N���gð�ɶ�����ۮ�m�}agbg�Ů��}�}��=���Z~s�r:V:ޚΜ�?}����/gX���3��)�i�S��Ggg�s�󈋉K��.�>.���Ƚ�Jt�q]�z���������ۯ�6�i�ܟ�4�)�Y3s���C�Q��?��0k߬~OCO�g��#/c/�W�װ��w��a�>�>r��>�<7�2�Y_�7��ȷ�O�o�_��C#�d�z�� ��%g��A�[��z|!��?:�e����A���AA�������!h�쐭!��Α�i�P~���a�a��~'���W�?�p�X�1�5w��Cs�D�D�Dޛg1O9�-J5*>�.j<�7�4�?�.fY��X�XIlK9.*�6nl��������{�/�]py�����.,:�@L�N8��A*��%�w%�
y��g"/�6ш�C\*N�H*Mz�쑼5y$�3�,幄'���LLݛ:��v m2=:�1����qB�!M��g�g�fvˬe����n��/��k���Y-
�B��TZ(�*�geWf�͉�9���+��̳�ې7�����ᒶ��KW-X潬j9�<qy�
�+�V�<���*m�O��W��~�&zMk�^�ʂ��k�U
�}����]OX/Yߵa���>������(�x��oʿ�ܔ���Ĺd�f�f���-�[����n�ڴ�V����E�/��(ۻ��C���<��e����;?T�T�T�T6��ݵa��n��{��4���[���>ɾ�UUM�f�e�I���?�������m]�Nmq����#�׹���=TR��+�G�����w-6U����#pDy���	��:�v�{���vg/jB��F�S��[b[�O�>����z�G��4<YyJ�T�i��ӓg�ό���}~.��`ۢ�{�c��jo�t��E���;�;�\�t���W�W��:_m�t�<���Oǻ�����\k��z��{f���7����y���՞9=ݽ�zo������~r'��˻�w'O�_�@�A�C݇�?[�����j�w����G��������C���ˆ��8>99�?r����C�d�&����ˮ/~�����јѡ�򗓿m|������������x31^�V���w�w��O�| (�h���SЧ��������c3-�  :iTXtXML:com.adobe.xmp     <?xpacket begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/" x:xmptk="Adobe XMP Core 5.5-c014 79.151481, 2013/03/13-12:09:15        ">
   <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
      <rdf:Description rdf:about=""
            xmlns:xmp="http://ns.adobe.com/xap/1.0/"
            xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/"
            xmlns:stEvt="http://ns.adobe.com/xap/1.0/sType/ResourceEvent#"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:photoshop="http://ns.adobe.com/photoshop/1.0/"
            xmlns:tiff="http://ns.adobe.com/tiff/1.0/"
            xmlns:exif="http://ns.adobe.com/exif/1.0/">
         <xmp:CreatorTool>Adobe Photoshop CC (Windows)</xmp:CreatorTool>
         <xmp:CreateDate>2016-04-16T08:54:43-06:00</xmp:CreateDate>
         <xmp:MetadataDate>2016-04-16T08:54:43-06:00</xmp:MetadataDate>
         <xmp:ModifyDate>2016-04-16T08:54:43-06:00</xmp:ModifyDate>
         <xmpMM:InstanceID>xmp.iid:c9c5edf7-5fef-a147-b344-b2f707aded05</xmpMM:InstanceID>
         <xmpMM:DocumentID>xmp.did:58f448f5-6d7c-c742-a8e8-7ecade15aedf</xmpMM:DocumentID>
         <xmpMM:OriginalDocumentID>xmp.did:58f448f5-6d7c-c742-a8e8-7ecade15aedf</xmpMM:OriginalDocumentID>
         <xmpMM:History>
            <rdf:Seq>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>created</stEvt:action>
                  <stEvt:instanceID>xmp.iid:58f448f5-6d7c-c742-a8e8-7ecade15aedf</stEvt:instanceID>
                  <stEvt:when>2016-04-16T08:54:43-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
               </rdf:li>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>saved</stEvt:action>
                  <stEvt:instanceID>xmp.iid:c9c5edf7-5fef-a147-b344-b2f707aded05</stEvt:instanceID>
                  <stEvt:when>2016-04-16T08:54:43-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
                  <stEvt:changed>/</stEvt:changed>
               </rdf:li>
            </rdf:Seq>
         </xmpMM:History>
         <dc:format>image/png</dc:format>
         <photoshop:ColorMode>3</photoshop:ColorMode>
         <photoshop:ICCProfile>sRGB IEC61966-2.1</photoshop:ICCProfile>
         <tiff:Orientation>1</tiff:Orientation>
         <tiff:XResolution>720000/10000</tiff:XResolution>
         <tiff:YResolution>720000/10000</tiff:YResolution>
         <tiff:ResolutionUnit>2</tiff:ResolutionUnit>
         <exif:ColorSpace>1</exif:ColorSpace>
         <exif:PixelXDimension>200</exif:PixelXDimension>
         <exif:PixelYDimension>268</exif:PixelYDimension>
      </rdf:Description>
   </rdf:RDF>
</x:xmpmeta>
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                            
<?xpacket end="w"?>��
c    cHRM  z%  ��  ��  ��  u0  �`  :�  o�_�F uKIDATx ��  47I���		�����  �� #���������������

   ������������������	������   ������   ���   ���������#���&���   ������
���	���������������	���������   ���������   ���������������
	���   ���

������   	������   ���(������   

������������   	���������

���������������	���������      
���������   ������   ������������ ��
���
$������   ���������	������������� ������������������������  		���������  ����  �
� �
  ����������������  ���������
������������

������������  ����������������

���������
���   ���������
		

  ����������������	���������������  �  ����	
���		������������  ����
���������  ������� ��������� ������������������������
��������� �	��������������������������� ������ 	������������������� ��������������������������� ��#��� ���		
��������    ������������������  ���������������	  ���������  ��������������� �
���
������������ ������ ���		
���������
	������������� �	����� ������ ���
   ���� ����	���������  ������������������� �������������	����������� 		���������������������������

������ ���������������������������  �����   ������ �����������	
������!�������  ������������  ���������������������   ������������   ���������     ����

��� �����   ������������	������������	

������ ����   $���   ���������������	

���������	���������������"���������	

������� ���������������������
���������������   ������� � ���������������������������������
	������������	������������������   � �������   ������   �����    ��� �������      
������������������
���������   ��������������������������������#$3������			�� ������������   	   ������   ������������      ������������      ������������������������	
���   ������   ������������������	   			   ������������   ���������������   	������

���      ������   ������	
���������		
������������   ���   ������    ��������������������   		������   ������         			
���������������	���	���
   ���������   ������������#&�  	���������������		
������  
 �����������������      ���������������
�������  ���������������������� ���������� �
���    ���
���
������������������  �������   
���  �������	���������		
���� �

��������� � �������   ������������������������������������	���   ������������  � ����  ������      ������   
������������		
���	��������� 	
��� ������  $&0���

������������	������������������

���

���������   ���  ���
  �   ������   ������	������� ���������	���  ����	��� ��������������	   ������	
���������������������	���
���������������������������������������  ���� ��������			������������������	  ����������������������  � � 		
����������������� ���	���		���			
���	
������	���������
���������������
	
���  ���� ��	������������������������������  ����������� � ���������������������������������� ������������ � ������������ ������  ����������  ����������	
   

������������������� �������  ���  �  �  ������������� �  � ���  ���������� ���������������	���  ���������������	
 ������������������
������������������   � �������   	���������������������  ����������������� � ��������	���
���            ���������  � � 

������������		����������������  ������������������� ��������� ������������������� ����������������������	
������         ��������������� ��������������������� ������� � ��� � �     ������������� �
������  �	
   
	��������� ����������������������� ��� ���������������������������������	������ � ���� ������� � � ���������	������   ������		�� ������������ ��  ����������������      ������������������ � ������    � ���   ���		������	� ����������		
	������������   ��������� ���      	������	

	������������	
������� ����	����� ������������  �������������   ���������������������������

������������
���������   ���� �������������&���	������������������
������������������������	���	
�� ���������  �  �   ������ ����������� �  � ���������������������  ����������  �  ������	
������������ �����������������		������������� ���� ������������������������
���   	���  �
 � ���	������������������  �� ������� ��   	
������
���������         ������		
����� ���  	���������������������������  �� �������������
				���	%���������������
���������������          	��� 	������        ����������������������������������  ���
������������		������
���  �

���������   ���������  �  ����������� �������������		���
		
���   ���������  �

���  ��������� ���������  ���  � �   �� ����  �������  ������  
 	������  � ������� ������ ������������ ������
 	���������    ���  ��������������� ",������	
������������������������������   ���������������  ����   ���������"������  �   ������������������    ������� ����������������  ������������ �   ���   ���	������		��� ������� �������
���  ���������������	���������	

 ����

������������������  ����� ����   ���	������������������������	
���	���		

������������ ���������   ������������'������������������������  �  �	
������������

������ ����� ������   ������  �   � ����������
������  		
���   ������       ������ � ���������������		
������

���"���������������������
	
 	������
��������������� 

��������� ��  �	������������	��� ����� �� ������������	������  � ���������   ��� ������ ���� ���������������	���  �������������	$���	
	
���������  ���� � �� ������ 			 ���   ������	���������������������

������     �� �������  

������������	��� ���������  �
���      	������������		
������������	���  �������������� ���������
��������� �   �������� ������  �
������������������  ���

���������
� ���� � ���	
���������      ������   ������  � ���������$��� ������  

���	���  ���������������  �������  ����	���������  ����������������  ���  ��  ���  �    ������   ���������������������������������������
���������������		
������	������
��������������������� �    ���
���	  ������	
������
	
������������	���������

   ��������� 	��� � ������		���������
������
	���������   ���������          � ���   ��������������������������� '���������	���	���	
���    ����������������       � ���  �	���  �  �	
������   
���	   ��� �����	
		������	���   �� ���������		
���������������   � ����� ������

������	
���������������������������	
 ��   ������������  �������������  ���������������������� � ��������� ������������ � � ����   
 ������������������������������������      ���������������  ����	
���������

������������������������     ���  �  ���	
������������   
   ������ ���������   ��� 	 ���������������	
������������     �   ���������������������   ������	

������		���������		
 ��������������������������������� ���������  �   ���
������ � ���  � � ���������
���

������		���� �
	  �
	������
���������������� �	
���������������      ���� ������$&0���  ������������������	������������������

������������
����    ������   ���������������		������ 
���������  �         

	
���������������"$,����������������  � �������  ����	
������������
   � ���������	�	���������������������		

���� �     ���������������������
��� �������������� ���������������������
������		������     ���������      ������������   	  ������������   ���   	
���      ������������
��� � 
���������������   	������   ������������������	
���

������������	������		   ������   ���������������	
�������         ���������   �����������	
���������   �������

���         ���   ��� ������   ��������������   	
���   ������������  
���   ������ ��  ������������	
������   ������������������������   ���������� �	"���  �	���������������   ������������ � 

	���		������������������ �   �	 � ������������������������������������   ������	������
	������� �  ���������		

������  ������ ������  �������	���   	���������  		
���������    �  ������������������ ���
	���������
��� ���    �  �������������      ������������ ����� ������ � ������
������������� ����
���������

������������   ���������� ������  �������������	���  ���������   ������������	
���������  ��������� ���
���������
�������������  ������������������	���������   ������������  �   

	����� ���		  ���������  ����			
������	 �����   ������� ���������� ���� � �����    �������������   ��� ��������� ������� ���	
������

		���������
����� ���  ����	   ���������		��������� � 	
���   ������
 � ���   ������������������������   ���      ������������  ���������	��� �����  		������������������������   	���	
� ����   ���� � ���		���
	������������������������ ��������� �	
������������������������������  ���������  ������  ��������� � ���������	������		��� � 
������������   ����  �� ���     ����   ������������������   ����������������  ������	������ � ��� �  �������� 

���������	���		���   �  ���������� ���  ����������  �   ���	
 �������������  ������������  ���  ����  ��	

���������   ������	
�������������� ������ � ������ � 	

�  ������
������ � � � ��		
���
���
�������������������������  ������   ���������  �  �   ��������������������������������� ������������		��������������� ��		
��������������� �������������������������������� ���� ����  ����������  �	� ����������
	������	
���������������   ������ � ������	
  ������  ���������   ����  ���������������
���������������  ���  ����������      ����������������������"����  �������������� �   �������������������

������������	

���  �    ���  ����������	
��� ������ � 	
���		���		���������   ��� � �		
������������ � 		
 ������
������������
��� ���������������������  ������� � ������
 ������ ������   � ����������   ������������  ���
������������������������	
���������������	�����    ���������	
���������  ��� ����  ������
���  ������ ������������	������   ���

������������      ���	  ����������
������������������������������������� ��������    ���������������	���  ����������� ��������� ������ ���	� ������������������������	
������������ 	������		 �  ���	�� ���
������  ��������� �
 ���� ������������������� �����		
���  ��� ���

�������� ���������� ������� ��� �������	

���������	
 ������� � ������
������������    ������������ ��� � ���  �������������������   ���������������	�������� ����  �

	  ��������������� ������������������ ������������������ � 	
���� ���������� �������� � � �������    �  ������������

���

������     	���������	�������� ������������������������������������������������������������

���		������  ���������������
���������		������������ � ���������  ���	������ ��������������������������������� �    � �������  ����   ������	  � ���������  ����������  ��������� ��     �������� ������������  � � ���������������		
������������������
��� ������������  ������������	

������������		���� ���	
��������� ����� ������ � �����  ��������������������������������
������������  ��� ������ ���	  ���	������������
		������  �   ������	
������     �  � ��������	������

���������������������������� ������������������ ���������������� ������������   ������   ��������������������� ���������������������
������������ � ���������   		
���������$���� ���		  ������� � 	���� �������	������������������	�����������������������  �   � 	
���
��� ������  ���� ������   	

   	

������ ��������������  ������	���  ���������������������   ������������������������   ���� ���������������   
������������   ���������   
���    
���������  ���������������������������������� �&)3���������	������  �  ����
���

������������  ������  ���� 

	������������������  ��������������� ������      ��������� ������   ���      ��������� ������������ ���   �������  �������������  ���	���	������������		
���   ������������������������	
��� ������������������������		���    ���������������������       �    ������
���������� ���		�������������������  	������  ���
 ������   � ���������	

 ������   ���������������������������������������  ���������� ������  � ����������������  ����� �		
  ���	

������������������ �����		 ������������������	������  ������ � ��� ���������������������    �������������   �� � �  �������������	
������������   ������ �������

 ��  ���  ��� �����%������   ���	

���������   ����� ���   ������� �� ����   ������������  ���������������������	������������     �������  ����� ��  ����   ���� ����   ������		������������
��������� ���	
������     �	
��������� � ������������
     	
  ������� 	���������������������  �������������	   �����  ���������� ��� �  ������
 �����������	������������������ ������  ����������������������������������������			������   ��� ���  ������
���		     ������      ���������
 � ������   ���   ���

���   ��������������� � �������� ��������������������������������������������� ��   ���������			���	���������   ���  �� �  ���������������   ������������������		   ���      ��� ��������   ��������� �����   ���������
������������ �� � ������������������ �    ���  		������  ���������  ���� ������������������������  ���  �  � ���������    � ������ � ���������������  ���������  �  � ����� �����������  ���	
������ ������������

������      ������� ��������������������� ���  �	������  ��� � ���
������������  ����������������������������	

������ ��������  ���	
���	


		
������   ���  �   ��� 		������������������������   ���� �������������������������  �   ���������  ���� �    ���
������������   ������������ ���  ������������	���
���������������������������������		���
�  �  ������ ��   		������ ������������������	���������������������
	���������	������	
		���	������������������������������������   ������    ������������

���������������������
 �� ���      ���  �   ���������������     ����������	��� �� ������������	
���   ���������� ����������   � ������  ����  �������	������������������������������	
������������ � � �   ������������������������  �
������������   ��� �������� ������  ���������   		����������������������������  ���������   ������������	
   ���������	
���������������������  �		 ���� 	
     	
	�������  ������	!",������� �

  �   ���  �������      	

���  ����  �     ������� ���   ������������������	
���
���� �	������

   		
������������������������������������
������  

������������         ���������������

 � ���������
���������������������������������
���� �������   �  ������ � ��������� ��� ��� ����������������  ����   '���� �������������        ������	    ���   ��������������� ��������     ��������� � ��� ��� � ���������      ���   ���������������������������������     �������  ���������  �   ���	���������������	������������������   ���������
���	������������   ���  ���	������  ����

���������   ���      ������    ������   ���������       ���	

���	������	   ���		������� ����   ��������������� 

���������	������������������   ������ ���

 ���������������  ����
���  �   ������������������   ������ ���������������	���������
���
������	
  ����	���������������   ���	������ � ������	���		���   ���������������     ����  ������������   ������	������������ 		������	
���������������������		
��������������������������������������� ��	
  ��  ��������������     ���     ��������������� ������ �  ������������������ �����������������������  ����������������� � ���	   ������	����� ���	��������� ������������������� ����������������   ������ ������ ���������������������������	
���   ������������������������������������������������ ��� ����			������������������	������������������������      �� ��� ��� � ���  		 ���� ����   ���
������������		������������	

���������      	���  �      ������		

��� � ���������

���  �������	
���������������������	���������������������	���������  ������������������������������ ������ ���    � ���� � 	


��� ��������������"��� ���������������������	  ������� �	 �  ��� �����������������   ���������  ������� ��������� � ������� ����������������������� ���� ����  ���  �     �      ��������������� ����� ������	���	���������  ����������������������������  ������		
������   
���������   ��������������� � ����� ���	��� � ���������
���
������������������	


������������������   ���  ����   ���  ������� �����  ����������������  ���   ������������ ��	
  �      ������������������������������������ �    ���  �  �  �      ����� ��� ������   ������������ � ���������������������
������	
���������������  � 
������      ���  �   � �	������ � � ���������������� � ������������
������     �	������  �������  ���$�������  ����������    ���  ���������
	
������������  ����������������
		
���	  ������ �  ���������������   ���������������������	
������		���  �	���  �   ����������������� ���  ��  ���  ���������������������	

������   ������	  ������
 �  �����  �   ���	��� � �



��������� � ���������������	   ������  �  �  ������#���� �  �� ���������������������  �������������������������       � ������

  ����������  ���������    ���������   ���		
���������������   	
������������  � 
������������������������   ��� ��� � ���������� �������  � �� ���  ���	������������	������������������������  �  �  ����   ���������	���	
  ����������	 ���������������������  ���   ������������������ ����  ��� � ���������	
������  �������   ���������

������������������   ���  �	���  �
������    �������  ���   ���
	

������    ������   ���������������	���������   ������������� ���� �������	
��������� ���������
���������  �������  ���������� ������������� �   �         ���		��������������� � ������������������ 
������������������   �����    ������������ �����	$����    ���������������������	
�� �   �������  �������� �   ���������

������   ������������		
		����������� ��    ������  ��� ������  ���������������        �������   ����������������	
��������������� ���������  ���������� � 	������� ������	��� ���������  �������������
���  ������   ������ � ��������������� ������  ���������������������&���� ���� 
���   ���������  ���������������� ���������	������������  ���������  �
���	
������	
   ������ ������  ���� ���	���� ����
��������� � ������������������������  ����������������	��    ������������		���������		
���  � ���������   ���������������������������		   	���������    �����   ���  ����������������  �� �������   ������
	���		��� ���  ��������������������������  ����������   ������   ����������   ���������      ���   ���������������   ������������   ������   ���

���������	  ���������������   ���������   ���   ������       �       ������		
   	������������������   
�  ���   ���������
	���
���������������  ���� ������      ���������
������   ������
���������   ������������		������

   ������������

� ���������������   ���������  ���	���	���   ���  ��� ��������� �����
	

���������   ���������   ����������������������  ���������������������������
������	���	������������������������   	���� ���������������������������  ������   ������    �       

������
���	������	������������������   ���
 
  ���    �������������� ���������������������
 ���������	
	
������ ������������   ���
  ����	 ������������������������
���������������������   ����������� ������ ������	������   	������������    ���
� �  ���	������	 � ������������������   ������������������ � �������� ���� ������  ���   �� ������	
���������������������	������������������ ������	������������	���   ������������
������	������"�������    ������ 	
���������������      ��������������������� ���������������������
���������   	
��������������������� �   ������������������	���  �  �  �������	���������	
������		
		������  ���
���� ������� �������������� �	�������������������   ����������������	
��������� ������
������� �
������������������������������#���������������   ���������		���������		���������������	���  ����   ������		
���������   ������������	������������������������	������� ����������������		���  �  ������������������������������ ���������������   ������  	��� ��������		
 ���		
��� ���������    ���� ���������������� ������ ��������������		
�	������	���  ���   	$&0��� 
	���������������������������������		������  ������������
���
	������������������	���	���������   ������  �  ����
���� ����  �� ����� ������������������ � ������������	
������������������		
������   ���	���     ����    ��������������	
������  ������ � ��������� 		������
������������������ ���������	
������     �������	

������  �������		�  ���      ���������		���������	������  %������	���������������������	
������    ���������������������������������		������     �� ������	������� �������������������������	������   		
������������������������	������������		
������������  �	���     ����� ���� ������������������������������������������������
������		
	
   ���	
  ����  ���� ��   ���  ���

	����� ��� ���������  ���������  ������ ���������
���������   ���	
 ��������� �� ��� ���
������������������		������������������  ���

	������������������   ������� �	   	���������		
������������������������  ������������������������  �   ������������������������ ���������  �
������	���������   ������  ���  ������   ���������������	������� ���� ������������  ���	�����    ������  ����������������   
������   ��������������������������� ��   ���	������
   ��� �����

�������� ���
�� �����������    ���   ������������ � ��� ����������� ������� ����	
��������� ���   
������ ������������  �  ������ � � �	���	���  ������������  �������������

�  ������	
������������	������ ��	���	���  � ������������ ���   ������  �     ��� ��������� ������������  
���
���������

������������  �������������������������������������
������������			
���������   ���� ����
������   ���	������������   ����   ���������   �������  ���������  �  ���	
���

���   		 � �	 
��������� � ���
������������������������
�������������������� ������    ���������������  ����	������	
		������   ��� ������  �   ������	������ �  ���  ��������������	 !,������  � ����� ������  �������������
	���  ���������������   	������������������
������
���

���������		
������     � ������     ���������������������������		���		
���   ������
������������������      
���	������������������

�� ���   �  	��������������������������������� ���	 ������������������������� ���������$���  ���������    �    ������
��� ������ �
�  ���   ��������� � ��� ������������
���

������ ������� ��������������������������� ������
��� � 
		������������������������������������
������ ������������������������������ ������ �������������� ���	
��������� � ���������������������   ������ � ����
���   ������
��� �����   ������������������������������� �  ������������������������������������   ���������	
������ ���������������������������������������������  ���������������

������������		
��������� � ������ ��������������������	     ��� ��������������  ��    ��� � ����� ���������������   ������������������   		
��������������� ���      ���
���������    ���������   ������
������   ����

�  ���       ���

� �   ������  �   ������������������  �������������������������   ���������� �		
���	

���	���    ������  �	���  ���	������������     ���     � 	������������������
 �� ������
������������	������������������	������   ���

������������  ���������������������   ���������   ������  ��������� ������		
������������
���	������		������	
���
���		
  �   ���
	���
������  	
���  ��� ��� �������	  ����������������	���������������������� �������		
��� ������   ������  ���	 ������������������� �������	���������������   ���������������������� �������������������������	������	������������ � ������		�  ���  �������  �  �������������  �������	���

���������������������   ������   ������������	
������  	������� ����	

 �����	 ������� � ����������	
   ���������   ���������  �� 	���	
���   ��� 	������������������		�����������   ������������
������

������������		���������   ���     �������  ������ ��� ���
������   ���	
��� �������������
���������     �

���   ������������������������������������������������ � ��������������� ��������������  ��������� �����������������������������������

��������� 
    ��	���� ����������   ������������  � � ��������� �  �������   �� ��� � ���������������� ������������
  ���  ����  ���� �   �������  	
���������� �	���	
��������� � ���������������������������������������
	������������� ����      ���� ���  �   ������	��������� �����������	���������    � ������ �  ������ ���  ������������   ���������������������������   	
���  �������
������������������������������������	

������ ������  �   			���������������   ������  ������������� �������		������ ������ ���	
�������������������� ���������������������������	  ������� ��
	

 ���
���	��������������������� ���	�������������	������	��������� � ������������������������  �   ������������  �������������������� ���   �������������������������������� � ���������������������  ������    ������������	���	������������  ���  	������������	
���
	      
������������������������������ ���	
���  ����������    ���������	���������������"������ � ����
���������� ������������������������
���  		   ���   ���������	��������� � ���  � ����   ������  �������������������  �� ���������   ���   ���� �		
������������������ ������ ������	
		�� ������������������	 �����������������  �� ���������  �     ������  �	  ������� �����   ������   ����������������  	
���������������		���%���������		���	���������
  ���  ����	
������������������
	

 ���������������������   ���������  ���� ������������ ������   ���������
������	
��� �����������  			����������������������������� ���  ����������    ���������  ���  ������������ ��� 	���������	
���������
������		
��� ��  ����	
���������������������   ������ �	
������� �������

���������������������	���    ������     ���������� �������������������  �������  ����   ���  ������������	
��������������� ��   ������"������������  �	������ ��������� ���������  ���������������������   ��      �   ������	���� �   ��������������� � 
������   ��������������� �������������  �����������  ���	
������ � ���
��������������� � � ��������"������������������������   ���
����  ������������		��� �  ������  ���������������          	����� ���  �  ������������	��� ���  � ��������������������  �����������������	��� � 	������������������� �������  ������		
 ��������   � ����������      ������������  ���� �� �     ������     � ���   
������������  �� ���������		   ������������������  ������������	
�������� �������� �������� ���������            ������   		  �������   ���	
�  ���  ���������������������������� ����������������� ���������������������  ��� ���������   �   ����	������������  �������

���������������   ��������� �   ��������� ��� ������������������������)�������� ������������    ��������� � ������ ���
���� ����	
���  ������
		���������            
���  ����	

������������		������������������	

���   � ���� � 
		
���  � �	   ��� � ���������		���		
������������������������������������������	������������������������  �   ��� �� �
���    ������������������������
������	���  ��		���������  ���

���������	
 � ���� ������  	
������������  �  ���������	
   ������������  ���������		������   
   ������	������������� �	�  �������     � ������������	
����    ��� ���������  ������    ������   ���			
���������������    ����	
���   ���� ���������������������������	���������������������������������������������������������	
��������� �������		 ������ ��	������   ������	
���
		
������������������  ������ 	������    ��������	������������������������  ���  ������� ���   ����������������������  ����

������������
���   �  ������   ���������������������������	���������������������
������������	���  �
���������   		������������������ � ������������������   ������'������������
��������������� � ������  ����
������ � �������
���		����  ������ � ���������������������   ������ ������������������	
����� ������ ����������  �� ������������������   ���������������  ���� ������������������� ���������������������������  � ��� ���  ����������    � ������
   ������		
�  ���������������   ���������������������  ������������������������    )������������������

���������

		���   	
������ ���  ���������� �����������������������  �������������    � ���������	

 �����   ��  ���
  ��    ������ ������������������  �������������� ������     ���� ������ ���   ���  ����  � � ��������������� � ���	������	���      ���
�������� ������
���������������������   ���������	
���������������	
��� � ���������  �      ���  ���������������������  ������� ������	���������	
 ��������  �   ���  ���������������������������������      ����������������� ��������� ������  ���� �����
������   ���  � 	
���������������������	     ������������   ������������	��������������� �	���������  ������ ������	
 ����
  ����������	   ��������� ���
 ��������� ������������
���������			
������   ������������

���������	�������  ����� ������ ����������� ������ ������	���������������������������	��������� ��������������  �   ���   	������   ������   	  ����������
	������� �	 ������      ���     ���������� �� ������������������������		������ ���
!���� �������  �������� ���������	������������	   ����������  �  ������  ����  ���� �������

 ��		�� ������  �	������ ������������ �   		  ������������������������������������   �������  ���
������   ������         ���		
������������������������������
������

���')1  ����	
���������   ��� ������������������������  
  ����   ���       ��������������� ������ ���������	���	������
	
 �����   ����������   	������������	
���������
������	������������   ���   ���������   ����     ���  ������������ ���������			 ���������			������     ����	
��������������� �����	����� 	���������	
������������  ����� ��������� � ������	    ���������  ������	����������  ���  � �� ���������������   ���� ����	���������  ��	
 � �������������������������  �   ���		������������������������	������������
���	
���� ����   �   ��   
���������   ������������   ��� $������   ������������������������������������   	
���������������	���������   ������   

������  ���������������� ������������������������������������	
���������������  �	
��� �� ����� � ���� ������������� � &����    � � �� ���������������	
   ��    ������   	����� ��������� ���
 � ���������������������� ����	 	���������	
 ��� ��  ����   ���������������������   ���  ���������������  ���   ���      ��������  �   ������������������������ � �������������    ���	
������		��� ���������	   ������		   ������ ��   ������    �  ������ ���������        �  �� �	
������������������		  �������������������  ���������������   ������	

	������ � ���			������		������������   �����   	
������ �����  ���� ��   �������	���  �������������	
	��������� �� ����������         ���� ����������������
	������������������������������������������������������	������������������ � ������	
������ ��
 ���������	
������			
���	
	
������������  �   ������ ���������   "���  	���������  ���  ������� �������������   

���  
		������ �������� ������   ���������������������������������������������������
  ���������������������	������� ����  �          �    

���������������������������������������	
��� � ���������   ������������	
���������������		��������� ����� ����  ������ ��	���
    ���������������  �

���������    	
���  �������������!+ � 
������   ��  ��������������  �������������  ����
	 ��������� ���������������������������������
���   ������� �   ���   ������   ������������   ���������  �   ������� ����	������  �   �  �	���������������   ���   	��� ��������������
������������������	
������   �����������  ���		���	
���������  ������ ���� ����������������	
            �  ������  � ������ ������������	   ��� ���   � ���������� ���
������������  ����	
������  �������      ������  ����	    �      ���   ���������������������������
���
������	
���� �������������  ���	
��� ������������������������ � �		���������  ���������  ������� �����

���	������������������������������
���������� ������������			������   ������

���������
��� ����� �   #������������	

���������� ����
 ���  ����  ������������  �   
������     ����  �    ���������������������������������  ������������� ���   ������������ ������	  �� ���		  ���   

	������   ��������� ���   ���������
���	������������������   ������ � ������������������

���������������	������	
������  ��������������� ������ ���		 � ���   ���������������      ������������������ � 	���	
���������  �   ������     ������   ���������������������������������������	���������  ���������������������  �  �������	
������ � ���	
���������	���������������������
���������������   	

���  �������������������
��������� � ���������
������	

���  �    �������  ���������
������	
  ������������        �   ������	������

����� ���    � �� ���        �	  ��  ����� ���������	��������������� ���  ������
������� ����  �	
 ��������������  �	
������������     �   	
������������������������	������   ������������  ������ ���������   	
		������������   ���		
   ������ ���   ���	������������������������		����������  	 ������������	  ���      ��� ����   �������������� 	   ��������������������� � ������������������	

������ ��������	
������������������������  �

������������������	���
������   		������    �����   ���	 ��  ���������
	���� � �   �
���������   	
������������������       �������      ������������������������ �	���������������   ������������	 �������� 	 � ���������   �������������� ���������
���������� ����  ������������ ���������������������������� �	
���  �������������  �   ���	���� ����������   
������������������		 � ������		���������������
������������������������������������������������������������  �  ������        ������� ���������   ����������������������� ��������������� ������	������

�  ���������������������������������	������������������  ���������� ������ �   ����������   ���� ������	������������ ������  ���������������������������   ���������������
   ���	������������ ������ ����  ���  ������������������
  		
��� � ���������          � ������������ �  � ������	������������������������������������������ ��� ���������
������������	
   ���������   ������������������������������������� ���     ������������ ��� ������

���

 ���������������������   � ���	
���� �������  �


	������������ �  ���������	������			������  ����	������������   ���   ���������������   ���������������

	������������      		
����������������  �������������  ����   ������������������������ �����    ������  �������   ������   ���������������
���������  �����  �    ������		
	   � ����  

  ���������������������   ������������� ����������������������  	���������������	������	������	���������	��������������� 	
������

���������������������		
 �������������������� �	���������	
���� ��������������  ������   ������������ �� '���  � ������������������������������������		��������������������� ���������������� �������� ����������������� �������� ��������� � ������

������������������������
     ���������������������� ����  ���������������        ������������   ������   ������ ��������������������������		����� ���������         ���������������������������  !���  		
������ ���������������   	������  � 	������	���   ��� � ���������������������������������������	�������������� ������ ��� � ������ ����� ������  ������������ ��������	���������
������������������  ��  ������������������  ��������� ���������������	������  �������   ������
������� ��� 		������      ������������������   
���     � ��� !������������  ���������������   ���

		 � ���������� �	������

�� � �   ���������     ����������������� �������	���
� ����������

���
	������������  ����
	������������	���������������	��� �� ������
���� �	������  �   ��  ����	������ �� ��������  �������������  ������ ���������  �	
����� �  �  ��� ����������������� �����������        � � � �


���  �	
���������������������	������
	���������	� ������ ���
������ ����� ��   ������

���������� �������	 ��� ��������� ��� ���
	
��������������������������� � 		  ����������� ��� ���������     ����������������	������	��� ������ �   � ����   		���		
������� �������������   ������
������ ���  	
������������������������  �������
  ���        ����������������������	������ ������� ���    �� ��� 
 ���  �   ������ � ���	��� ���� � ��   ���� ����������� �������������������   ������������������		
���������������  � ������������������������  �     � � ��� ���   ��������� ������		
 �  ��������		������  ������������� ����  ������  ����   ������������ ������	���
���������������     � ����� ������
��������������������� ��������  �   	
����������		��� � ���
������������������������������ �    ���   ��������� ������

������		

�� ������������������  � � ������	���������������� ���������  �  �  �      ��������� ���� ������������  ������������ ��� 

���  ������  ���	���
����������������������  �������� ��� � ���  ����	������� ����������
������   ������������������ ������������   ������  �     � � ��������������� ��� � ���������������  ���������������	
������������ � ������  ��������	� ����      ������  �   ���  � ������  �     ����  �������������   ���     ������ 		 ���������   ���   ������������		   ���  �   ���������		
������ �����������������  ���      ������ � 
���	���������������   	���

���
������� ���������������� �����������  �	
�������������� ������	� �������	������   ��� ������ �  ���������
   ������������ �� ������	 	  ���  ���  ������
���������
���	��� �� �  ���� ���������� ���������������������  ������  �������	���   ������
���   ���������  ���������������
������	������   ������������ 	��� )		���
��� ��������� ���		������   ������������
  ������������   ���    ���������������   ���������	
������������	
���		������������    � ���������������� �������   ��� ����������������������������������������������   ���  �      ������� �	 ��������������
���
�  �   ��� ������������	���������	
    ���������

 � ��� ������������������� ����������������� �������
���������������	������������   ���		 ������� � 
���	
������������������������ 	
 � 	������������	���������������		���  �  ��������������� 		���
   ����������   ���   ��� ���������������    ��������� ���������     ����������   ������	
  �	������  ������������

������������		���������������	�    ����������������������   �� ���	������������	  ���������� �������������������	������������������������������    �����������   ������		�� ���   ������  �   ����  ������������������������������������	������������������������ ��  �������  ����������������������� �� ���������������������������
������������	
��������������� ���������������  �	
� �������

���  ��(���� ����
	���������		
������ � ���			 ���������������

������ � ���	������		   ������	���	��� � � ������� � ���  �������������  �  �  ������������������
��������� ����������� ���� � ������	������������������������
�������������  ���������������   ������	
������  ���������������   ������������  �  �  �������������������� ����   ������������

	�������������  ������� ������������� � � ����������
 ���������������������������

���������  ���      ���������	
       ������	
������������	���
���
���������

  �������������������� � ���������	������	
������				���   	������	
���	������
���������	���������������	���   ���������   ���   ���	

 � ������������    ���������	������   ���������������	���	
 ������  ����������  ����������������  ����� 	������ ������������  ����������  ���
������������������	���	
���     ������ ����������� ��������������������	��������������������������������� ��������� �  � ������	��� ������������	������������������      � ��  �   ���������� ������   ���������������		
   ������������� �� �		���������
	���������� � ������������ ���	���������������		������ ���������   ������������ ������������ ���  �	�  	������ ���      ���  ���� ������������������������������	

 ������ ���������������������
������������		��������� � ������ ���������������
������������ ������ �����	
��� ����� ������   ������	
�������������������������  ��� ��������������� 		
���		
������ ���������������	
���$������������������������	���������������������������		���������������������������������  ���     ����������� ���������   
������  � � ���������������	������������������  	
���  ������	
 ����������� ����������������������������������   ���  �������������������      �������� 	���������   ���      ���� ��������� �������������������������������������������������������������   ������������������������������������  ����������������������������������������  ���������������������������������������� ����������������������������������������	

�� ���������		���� ������������ � ������   ������
	
���   ���� ������ ���������������      ������   ���������������   ���  �        �������������  �������� �������������������  �   ������     ������ $������   
���  ���	
��� ���������  ����������������   ���� ���������� ���
���������			���������		
 ��� ������ �� ������������  ���������� ������ � �������������� ���������


��� �����  � 	
������������ ���  ������������������ ������ �   ������� ������ ��
    ���       � ������������ � 	

������������������  ����  �      ���     ���� ������'������������     � �������    � ���

���  �   	���������  �      ������������	������	������ 	������    ��������

��������� 	���	
 ������������ � ������  �  ����
������  ����	������������������������������������������������������ �������	
� ������� ���   ���������
  	

���
   ���	
���������  �   ������
������������!������	���  �������������������		����  ���  � ������
��� � ���������			���  ����������	���	

	
������������������� ��������� ���	
������ ������ ������     ����� ����  ���  ���	
  ����������������� ���������   ���
 � ���� ������������������������	  	������	
�� ���
�������������  ���   � � � ��� ���  �������������	���  �� ������������������	������������		���������
  ���� ���		���	�������������������������������  ������������������   ����������� � ���� �����������������������    ������	������  � �������	
 � 		���������������    � ���������   ���� �	



��������� 	������������������������    � ������������������	
������	
	���������  ������
���	
	 ��   ��������������������������������� ���   ��������� ������������������  � ����	������������������������   ����������� ������		������   


������   �����������  �������   	
������    ����������

������
������ ��  �   ������	
���������������    �����������  ���	������  �������      ������  �������  ���������������
   ���	� ���	���

���	���������
���	��������������������� �������   ������������������������    ��������������������   ���     �� 

��������� ���������  �������

������  � �������������� ����������������     ��� ���������  ����	���������   ���������������������  �    ���	������������	���������������������������		���  �  ����������
		��� ������������������������������������������
	������������
  ������ �� ���������  �������������������������
���	
���   ���������������  �  ����
������   ���������   ���������   	��������������� � ������� ������     ������	   �������������� ������������������������������   ������				���		
������������   ���������� �   ������������������
���	������ ��������������������   � ���������������������	&���     	�������� ��������� ������  �� ���������� �������  �   ������ ���   ������	
����������������������������  ������ ���  ����		���   ��������������������		

� ����������	���� ����
 ���������������   �������  ������������	
������� ���  ������
������      ����	
���������������������
������		������� ����  ��� � ������	��� �������������������� ������������������������   ���   ������������������  �   ������  �	��������������������������� ��������� � ������������������
������	������	���������	����   �   ���������������� �     ������  ����������������   �������������������������������  ��������������������� ������������ ��������

��� ������������ �   ���	 � ����
������������(������   ���  �           ����  ���������������	      ���  � � ���������	
������������ �   �������   ���������������  ���  �	���� �� ���
	���		���   
   ������������������������������������������
   ������	 �		������������ ������

������������������������������	
���������������	������	
���������������������������������������  �  ��������� �����  �
���������  ���	
������������	
���  �  ������������   � �������	
���  �    ��� ��� ���   	 ����������� � ���������� �		
���	������������������������

���  ������������������   	�� ������ 
 ��������������������	
������������������	���		������
������������������	���������������		���������������   ���
���������������  � 
����������������   ��������� ��� �
������   ���������������    � ����    ����������  
 �� ��    ����������   ������
  ���
�������� ������������		���������   ��� ����� ��   � ������   ���������������������
���	
���

���		������������
	

������	

������   
��������������� ���� ���    ������ � 	  ������ 	������
������ � ��� � ������	���������������������������   ���������       �������       ������������ �    �������������������     ������      ���������      ���   ���	������	
���������������

�����������   �� ����     ���   ������������       ������������������   ���   ���   	���������������������   ������������      ���������    	������      		�����		���	
   ������������������������������	���   ������	���������      ���
� � ���������������   ���� ����������������������������	
������  �   ������������������������		���������������     ������������    ��������������� ������������ � �����	������������   ������  ���  �	  	
���
������
����������������� ������������   ���� ���   
������������������
  ����������	���������������   ������������ ���������  ������� ���	���
���������   ������ ������������������������������������������� ����   ������������������ 

���	
���������"

	���������

������������� �������������������������������� ������������� ��� � ���������������

������������������������������������			
���	

���������������  �  ���������

 ����� 		������ ������		���   ��� �������� � ��������������� � ���  ��  �������  ������������������������� ���������    � �  ������������	��� ������  �������   

������

������      ���������    � ������������������������������
��������� � ������������������������	
���������������   ������
������������������� ���������������������������������������  ������������	
������ �  � ���  ���    ���������!������	      
	
������	
�  ������������   ����  � 	  ����������������� � ���������	
������
���������������  ��� ���������������������������������  �   ���   ������   ������   ����������� ���������������	
	 ����� � � ����������������������������������			���������  �  �      ��������� ������ ����������������  ���������� ������������������  	���������������   ���������������"�������  	���������������������������   	
������   ���� ������� ������������ 	�� ���   ������   ������������������  ������ 	���������
		
���

������

���   ���		
��������������������� � ������������������	
������   ���������������  �
���������� �������  �      		����������  ��������������������� 
     ����    � ������������	
������	������������������   ������

  ����������  		��������� ������������������������������	
���   ���			
������������������������������	  ����������������	��� � � ���� � 	   ������������������   ������  
������		   ���������   ������������			������� �	
���������������   ������
������������	��������� � ����������   ������������  �    �    ���   ���������������������   
	������������������������������ ������������������������ ���������������� �   ��������������������������������������� ������������������     �������   ���  ���  ���������������������
 � ���������������������������  �	������		������
���������������   
���� � ��	���	
������	   ��� � ������   ���    ��� $��� ����������������� �������   ��������������������������������������� � ���������� � � ���� ���� ��   ������������������������������������   ���  ������  �������������������������  �������	
���  	  �	������� �������	
���������   ��   ������������������� ���������������  �	 	��������� � ������������  ����	���������������������	
���������
������  �  � � ���������������   ������������������������
��� ��		
������
���������������
� ��� ���������������������   ���
������������
���������������������������������������  �������������		 ��������� ��  ������������ ����� ����������	
 ���   ������������	���  ����������������  �  ����		   
������	
������  ���   ���	������������
�������  		���

���������������   	
��� ���	
������
���
 	���������  ����		��� ������������������ ���������������������   
������	
  ����� ���� � �
   ���  ������������������������  � � �  ������������  �  � ������  � � ���  	
���   	
	
 
  ���� � ���������   ���������
���������������	������     �  �   ���  �������   ���
���
������������   ���� ����	������������   ���       �� ���������������	���������  �  ������ � ���������� �������   ���������������������������� 
������������� ����  	������       ������      ���� ��� ���   ���������  �������  ������   ���������������	���������		���  �	��������� � ���  �   

������������������������������� �������������  ������������������  ���  �     ������� �����������������	

���������	   ������������   ������������ ������������	
    ������������	���������  ��� ���
������

   ���
	���������    � ��� �����   ���   ����� ������  ���� �   
���������	������������ ���������  ��� ���������		���
�� ������������  ����		
������   ��������������������� ���������������    ���   ���#���  

���������			   ������   ���������� �������  ������������
���
���������������	������ �����  ���������	
������ � ��������������� ���  	

������������
���������������������	 � ������������			
   ���������������   ���  	
�   ���������

    � ��� ���������

	
������������������������      		
������   ������ ������ ������� ����������   	� �������������������$ ���

   	
������������������ �����   ��������� ���  �� 		
��� ���	��������������� � ���������������	������ ������	
������ ���������������   ������ ������������������������������������������������ � ���������������		
���������  �������	
����������� 
   ���	������� ����

	���������������������   �  ��� � ������������������������������   � �������   ���������������������������������  �   ���  ����������������	������������������������	
����� ���������  �������������������   ���� ���� � ���������    �������������
�� ������
������
	

������
  ������� ���������������������	������         ���  ���������������������������������������� �	���������������  ���� ���  �  ��� ���   ���� �� � ������� ����!���   
����  ������������  ���� �����      ���  ���������� � ������
	���������     �   ������  �     ��� ��������������
	  ��������������� ���������������������  �   ���������   ���������������� ����������  � ������ ������������   ���	���
������������������������
������� �
������������������������   ������������  ���

������������  ����������     ����������������!���  	���������������� ��� �� �   �	������ ������������  ���  �������������������������
��� ���������  �   ������	�� ������	
������������� ����������	

������������	
������������	
���  � ���    ���  �������������  ��� 	
���  �������������  ���������� �������������   	
������       ���������	������������������      ������������ ���     ������������������ ���    ���   � ������	����������� ���������	���������������	���������������  ��������������������   �������	
������  ������		������������	���   ������  ����  ���������  �������������     � �������������������������� ���������  �������	�  ���  �������������	������   ���������
	
������	
 �����������   ������		
������������������������ �����
���	
��������������� ��	������
���
������ ���   ���� �� ������������  �     �!���������   ������	
������  ���������	
������������������	 ������������  �   ������������	���������
������ ���	
���
			������������	
��� ������������		
 ���� �������       		���������	���  �  ������  �������� �
���  �     ����� �������	
���  ������������������  ���� ���   ���������	
� �������� ����
���	� � 	������� � � ������   ������ 

������������� ����     �� ���������������	
������������	������  �   ������	���������	
��������������������������������� � ���	���������   ������������������ ���  ����		
������
���� � � ������ ������������������� � ��������� ������������������   ���������� ���  ������ ��   ���   	������         ���� ���         ���������������   ���   ������		
���������   ���   ���������    ������������������������������������  �
��������������������	
������   
 �����������      ������      ���������            ������ �    ���������
	������   	������������������      	���   ���   ������   ������������	
   ������
���	
���������   �����������   ��� � ������		���������        ����  �������������������������� ���������	������  ����  ������     ����  �

��� ������ 
 ����������� ��� 	����������	
��� ������	������	����  ���� ����	
���������������	
���������������
���		������  ���� ��
���������  ����    �������� ����  ��������������������������������	  ���������



 �����������������  ���������   �������� ������ �   �      	

���������     ������   � ���		

 � ������  �  ������������� ������ �����������������	������������     �������������������������	������		������������ ������������������ ������������������������   	
������		
���	

������	������������������������������      ���   	������������������ ���	���������������������������������������   	
���������������������  � � � ��
������������������������  �   ������������������
���  ����������     ��������� ���������	��� �  ���

	���
	
������	 ������ ��������� �	��� ���   ���������� ����   ��� � ���������   ��� �    

  ������  �������   ���������   	������������������	������ ������������ �  �� � 		
������������  	���  

������	������������� �������!���    ��
���������  �������������� ����  � ���  ����������������������������������  ����   ������   � ������� 
���������

���������� 
������		������   ���������������������������������������  �  � �   �        � �����
������������������	���   ������ ���������������������

������������������   

  ������


���������������������   ������ )���  �     	���������������     ����   ���������  ����
���	������    		��������������������  � ���        ����  ������������������

���������		���������������	���������	
������   ���������	
   ���  �  �  ��� ������������������ �� 	
���������������������  ������������������    �  	������	������  ����������
������   ���������
���������
		
   ������������  ��          �������  ������������  �  �	�  ������������� ����
������������   ���
������	������������	
������������� 			� �������   ���������
���
���   

�� 
������   ���		  ���������   ��������� ���     ����
���		
������������������	
������ ���  ����������������������   �  ��� ���	
���������������   
���������	
������	������������ ��������������������������   ���     �   ���������
	������������� ������������� 	
������������	���������  ���������������   ���      ������������   ������������������	 ������
��������������������� 	���    ������	�������  ���   ���������  ������   ���  ���������� ������	
	���������	���������������  �������������  �  ����   ������	   ���

���	���     ������   ���������������  ������������������������������ ���������	� �   ���   ���������������������  �   ���      ���	���	 ���������  ������   ��������������� ���  ���������
 ������������ 	���	���  � � ������		������ � � �   ������    ���������������  ���������������������������������� ���    ���� 	��������� � ������������������� �   ������	 ����������   � 			
 � ������		������   ��������������������������������� ��������������������������� 
������  ���  �

��������� � ������������   	

���������  �������	���
������ �  ���  ����� ������������
  � �������������������������   

���  �
���������������	
���������� ���	������� ���	
 � 

������  ��� !���   ���  ������  �� ������

��������� � ���   	���������������������    �	
������		���������������������

���������

���������
������

	���	���� �� �������� ������� �����������������������
������  ����������������
 ��������� � ������  �		�� ���������������
������	������������	
��������������� ��������������������  ����   ���	
������������

������������  �	������	������	��� �����  ���������
 ���   ���������������
���������   ������	

������   	
	
������
��������� � ���������
���		 ���� �������   

���
���������   ���	���������      ������������	  ��������� ���� �������������
���������������������     ���������  ���������������(������������������������������ ������	������������������� ������������������
������������   �������� ������ ��  ����������������  ���� �������������������������  �������  �������    � ���   ���   ������   ��   ���
���� �������  � ���   ������������	  �������  �������  ������     ������   
���������������������������		
������������������	������������   ��������� � ������
������������      ������	��� ��������������������� ����  ������������   ������������   ���     �   ���������	����������������  
���� �������������������	������������	������������� �������������������������������   	   ������	

���������������������   ��� ��������  � � �
������������ ������	������ �� ��������� ����������������!���
������� ����	
	
	
������� ����

���  �   ����������   ������   ������	   ���   	��� ���������������  �������  �������������  ������	
���������������������	
���	������	
������ � ���������������������      �������������  � ������ ������������  ����   ���� ���������� �		��������������� ��  ����������������

���������    		������������   ���   ������     �	������   ���������	
	   ���������������������    ���������     ������������  �   ������		��������������� ������	�������  ������	���������������������������������	��� ��	������  �  ������   ���������������������������������$���������������
 �����������������
���������  � ���� ������   ���������'�����  � ������
������  �   ���   ���   ������������   ������������������			  ���������������������   
������������
������������
���������������������������������������������������	������     ��	���������������  ������������������

���������������� ����������   ������
������������������������� �������	���������������������������������   ������	��������� �     ����	 	   ������ ������������	���   ���
���  �������������� 		������������   ������� ����������������	
���������  ���������������������  ������			
��� ���  ��������������� ������������������

������    � �������� ������	������������� ������    ��������	���������������   ���

���������  �������    ��������������������	
��  �������������� ������������������������������� ����      ��� ��������	������������������������������������		
  ���   ���������   ���  �������
   ���    ����������� ���������� �	
���� ���   � �   ������������������� �	������    ������ �    ������������������ � ���������
  �������������������������������������   ���������   ������������    � 	 ������������	�� ������

   ���  �   ��� � ������������  ������	
������  ����������   		
������������������  �   ���������  ����      ���	���  ���������������������������������
��� � ������������������  ���������� �� ����� ������   ��� ������� ����  ���   ���������������   	 ��������   �������  ����������� ��������������   � ������������������������������������������������   ���������   	
���   ������  ������      ����		���

���������   ������������������ 	
	��������������� �������������������� ������������	������������������������  ��������� � �  ���������������   ������������   ���	
���������  ���������    ������		
 ������  � ������   ���   ������������   ������
"���   ������			������������������	������	��� 	�  ���������  ������   ���� ������������������ ���  �   ������	������
 �����������������������������   	������   ������


  �������		���  ������	�������������������  ������ �������	  ������������������	������ �� � ���		������ �    ���������������  ���   

��� �����  ���

������������������		
���		
���������  ����   ������������������������������������	
���  ������  ������   	
	������������	
������   ������   ������������������ ���  ����		

���		  ���	

���������������		
������
� �������
���������		��������� � ������������
   ��������������������������� � ���������	
������������   ���	����� ���������	���  ������������� ����� ���   ������������������	������
 ���������  ������������	  ��������� ��������������   		
����� ������	  ����
������   ����� ���������	���� ������������� �����������������������	���   		
���������������������    ������������������������������������ �   ��  

	

������           �  ���   ������   	���	
����������� ������ � ������� �   ������		������ ��������������������������������   ������������  ���������
   ������������   ���	  ��  ���������������������������������������������������   ���	���������������	��� �������� ������ � ��� ������	������������������     �  

	
������  ��� ������� ������� � ������  ������ � ���	������

���������  �	
���������   ���  ������ ���������		
	���������������������������   ���������   ��������� ���������   ���   ���
��� ���   ������������������������ ������     � ���������������      ���������������     ���	���        ���������������� �   �������		
�� ���������
���  ����������������������������	����������������������������������  ���  
	������������������������������������   �����������  ������������������������   ���������������������	���������������	������  �	
���  �  ����������������������������������������	������   	
���������������������������  ����������  ���  ���� � ���������     ���  ��    ��������� 
������	������������ � 	
���������  �������          ���������������   ���  ����    �����������   ���    ���	���     ���������   ���    � 		
������������  ���� ���#������ ��	���
���������������   

  ����������  ��������������� �� ��� ��������
	
������	
	   ���   ������
���	��� ���  �� ���
������  �������������������	��������� � ������������		������
������������ ��������������������� ��������         	
� ������ ����������             � ������ ������������  ����� ����  � ���������
���� � ������������ ����		  	
������
������������������������
  ������������� ���������������������������������������   ���������

���
������������������� ��������� ��������
     ��� � ������� ������������������  		
������ ��  �������	������    � ���� �������������������    �������	
���  ����   ���������  ����������
 � ������������  � ������������ � ������ ��������� ������� ���������  �	

������������������������  ���������	���������  ���������������������  �    ������ ������   ��� ������	

���   ������   ���������    ������
 �������������� ������ � ���������	
������ ����������������� 	������������ � ��������� 	
������������������
������������������������	���  �		 ������������� ����������    ����������������� ���#���� �		���   ������������  �     ���������  	������������������������	������������	��� ��� ������

���	  		
������������������   ���
����  ���   �����������      ��� 

���	�� ������	  ���������  

 ��������������� � �� ������������     ������   ������	���������������		    ����������   ������ ����� ��������������������� ������������������	
��� ������   ���   	���������	
������	
������������������  ��������� � �������������� ����  ���  ������������
  ����  � � 

���  ������� ��������� �

������   ���� ����	����������� ������������������
���   ���
��� �    ������ ��������� ��� ����� ��� ���	������ �����   ������  ������������   	������������������   ���  ���� ���������������������������� !������� �

������	
���������� ������  ���������
	���	������   ���������������������������������� ���������� � ���������������	

���		���
���������������� �	���������������   ���   	��������������������������������� ���������  �
� �		������
  ������ �����������������		
���   	��� ���������������	������  �  � ���		
���
���������		���#������������		���		 ������������	������������	
������������   ��� ������	
� ���  	���������������   ���������  ���������������� �� 	������  �      ���������������������         	
������	

������		������

������������������������������������������ 		
���	
���  ���������������� � ���� �  ���������	������������   ������� ���������������	���	���   ������������    ���		���������������	���������������������������� �� ���

���	�������  ���	 ���������
	������         ���  �   	���������     �������� �   ��������������������������    ������  �   ������	��������� ��  ����������������������  �  �������   ���������  	 ��  ������	
���
���������������  ������� ��  ����������       
���
������� �������	
��������� ���  �  � ���������   
���������������������
���   ���	������   ������   ������������������
��������� � ���������   ���   
	���������������   ���	���
	������������   ���      

������������   ������   		
�������  ����������         ���      ���   	
������ ���������		
   ���   ���      �������������������������	���      ��� 	������	
���������������������    	������   ������������	
 � ���������������
� �
	
 ������    ��������� ��������������������� ������������ � �����������  		

��������������������� 	
	
���������
���������         ������

������  �   ���	
���������   ���������  �   ���  ������������� �   �������  ���  � ���	
������
������  ���� ������ � ������������� ��	������   ��������������� ���������	���������������������   ������������� �������������������������������������  ������  ���������	��������������� ���������  	
������������  �      ������ �������   ���  �������������  ��� �   ����  �  ����	


���������������   ������������	���
		������	���
��������� ���������������	
  �������
���������������������������������
������������  ��� 	
������������������

���  � ������   ������� �������������������� �	 ������������������		���	
������ ������		
������������	���		   ������������  ���������������������  	
���������  �  �  ���������		������������   � �������	���������������     ����������	���������������  ������������������� ������� � ����  �
���������	���
������������������������
������   ���������  �������     ������	������  ������������� ������������   ��� � 	
������
����������������������������  ������������������	
���	
������   �����      ���������
���������
  �������  	
������������������� ����	
������������  �	���������   ��� ���������	
���   ���������
������� ������� !*������������
���������		
������  �       ���������	��� ������������������� ����	
���   ������	������
  ������������	����������������������������������������� ���������
������������  ������   � �	
���   ���������������������������	���  �������   ������	  �������  �������	

��� ���� ��������������� �������������������� ��
���		
   

������������������  �	
���������������  �      ���   ������		
���������������������  �  �   ���
������ �  ����� � ���������	
������������  �������		���	
����� ���������   	���������������������� �������  ����������� ����   ������		��������� � ���������������	������	��������������������������� � ������������������������� �������������  ������ ������������� � ������


���������   ������������������  �   ��������� 	���������������      	���������    ��� �����������  ����������������������������������������������	
������� �������������� ����������   ������   ���������������		
��������������������� ������������ ���     � ������ � 	
���	���	�������������������������  ������������������������ ���   ���
������������������ ������  ������������  �   ���������������  ���� � ���

������		�  ������� �   � ��������������������� � ��� � ��� �   �  � ���� ������� �   �   ������������������
���������
��������������� � ������������������  ������
   ������  �  �    � 
������������   ���������������  �  ���� ��� � ������������������ � ���	
���������������������� �������	 ���������   ���      ���	�����������������
���	    ������	������ ���  �
		��� ������	��� ��������� ��	 ������ � ���		��� �    			������ � ��������� ���		���������������������������  �  ���� � ������ �������������� � ���  ������	
���
��������� ��������������������		
������       ������
���������

������������

������ ���
 �����������������   	���������	 � ������������������������
!*���  ����
� ���� ������ ������������	
������
������  ����    ������	

���  � �        ������� �  �
������		��������� �������   ��������� ���������

������
���   ������������������
	���
���#$*���
	���������������������  �        �


�������������  ������

������������
���		
���������
  ������	���	���������������������		
	���������
���

������������������ � ������������������������
������������������	
		��� � ��� ������������������������ �� ������������	
������  �	
������
������      ���

� ���   		
���  ��������� ���    �������  ���������  �    ������������  �  �		
	
���	
���������  �    ������      ������  ����������������  ���������������������	
���������������   	������������	���������	
��� ������� ����	���������������������������	
������������	���������  ����������������  ���    ��������������������� ���������

��������� ��   ������	
�� ���	������  ��� ���������  �������    ���������������  �������     ���� ���������   
������������  �    �    ���   ��� ��������� ���  �
������		
���	
���

���������    � ��� ��� �  ���������������������	  ����������  ������������� 	���	
������������ ��  ����������������� � 	���������������
   ������� ���������	��� 		
������������������������  �  �   �������������     		������   ���������	

���������      ���������  �  ����������������   ������	������  ���  �	��  ��   �����������������  �����   ������������ 	���			��������������� �    ������������ ���������� �		��� ���������  �    ����  ����������������

������  �	
���������  �   	������			��������� ��������������� ���
������������������������	
��� ���
   

������	��������������������������� ������    ����   ������������������������������������   ����������  ������������
������������ � � ����       ������������������������  ���������������� ������������  ��� ����� ���    

		������������������				������ 		������������������������   	������������	� ������������������� ���   � ����������������������	
������	 �����	
������� � ��	���������
������������	���������������  �   

���������   ���������  ���	
���������  ����������������		
  �������  �   ���������   �������������	������������   ������������   ������ � 	���
����������������������������������������������� �������������� ���������

������������   ���		
���������	

���  �   ���������  ���������������
 �������� � ���   	������	   ������ � ���	���   ������  ������ � ��������� � ������
��� �    � ������  �������
���
������	������	������  ���������������   
������������  � ���������������������������������������		
���������������   ������������  �������������������
���	���	      ������		������������	

	
�� ������������
������������	��������������� ������  �������������  ���   ������������		
���  ������   ������  �  ���� � ������	
������	���������������������    ������ *������  ���������������������������������� ������������ ��� �������� ���������  �      ������   ������������ �����	
������� ������ � ������   ���������  ��������� � 	���������������   
���������������������	
������	��� ��������  ���   ���������������������   ��������������� �����������    � ��� ���        �������������	
������   ���������   
������	���������  ��������

���������

���  �  ������

	���������	

���� 

������� ������������     � �		������������   ������������������������
������	���  �������������  �	������� ����������		   �������� ������������������		
� �������������������

������� ����	
 ��   ���      ����    �	���    ������������������  �	����  ������� �

	���   ������
���������		���������	�������   ���   ���  ����
������	����� ������������������������������ ��


���   ������������		���������������������	����������������������������������      ���������������   ��������� �����������  �����������������������
������������ 
������            ��� ������   ������������������������	
������ ���

 �	���   ������  � ���  �����
������������������		� �  �������������������������
���		
������������������ ��� �����   ���������������������   ������������   	��� ������	������	  ������ ���������� ������������    �

���	������ ���	   ������������������������	

	���   	���������         

�  ������������		���   ���   ���������������	������		������   
�� ���     �� ����'��� 

���������  �������������������������		
���������������  ��    ������
 � � � ������������������ �  
���������� �����������������������  ���� � ��������� ������������������	   ��� ������������������������   ���	
������������   ������   ���������  ���������   ������         ���  ������������� ���������� �    ���   ���������������������	���������������������   �   � ������������   ���������	������������  �������������������		  �������	
������   	��� �    ������ � 
� �	
������   ���������� ����  �	������������	

���   ���		��������� ������������		

���������   	
		���  ���������������  �   ��������������������� � �  ���     �	���    � �������������������������������

������������  ������������  ��������� ������������������  �     �      ���
����������������������  �  ���������������	
������   �������	
���� ����������������
   	���  ������ ���������������
���������������  ����������������������������
  �������������	
���

������ � ���������������������  �������������  �  ������������   ���������������������������
  �
�  ������   ������
���������  �     ������������������ ��  �      ���  �		���������	
��������������������������� 	
������������������	 ��� �� ��

	
���	������         ����������������

���������	
��������� �� ���������    ���  ��� � 	
��������� ������  ��������������� � ��� ���������������  ������	
������  ��� ��������� � ��������������������� ��   ���������   
���  � � ��� � ������ � ���������������������  ����������	���������	���   ��������������� �    ������������     ���������      ���      ��������� �������   ���

���   ������������� 	���������������   ������ �����		������   ���  �������
������������ ���������� ����   ��������� ���  ������ ���   ���
    ������������������ ���������      ���� �������	��� � ������	
������������������ �  ��  �
���������������������������������������	
���������������  �  �  ������� ��  ��������������� ������ ��������	
������� � ���������	  �����  ������ �� ���  ������������ � ���������������	� �	������������������ ��������   ������������  ���������   ������������   	
 ������		%(2���

������ ��   	���������� 
���������  ����	������������ �����������������  ������������������		
��������������������� ����  
���		������   ���������������������  ������������������� ����������������������   ���������    �������� ���������� ����������������������  ���   ���� ������  ���	

���������    ����������	���������������� ����������      ������ ���������

���
	����� ���   ���	������   		������  ��� ����
������     �
������ ��
	
		���	
	������� ���� ���  ������������	������  ���������������������������		
���   	������  �������������������		������	������  ������������  ������������
���	������������������������������������
���������������������������   ���������������������������
��� � ������������  ���'������		
���������
������������������ �����  

������������	���������  ������     ����������������  �������	���� ���� ��

���������������		
������	
���������	
���� ������������ ���
������������������		
���   ���
������������   ������
	������	
�  ���
���		
��������������������������� ���� ������������    �����   ���������������������   ��������������������� ���#%0������  ������� ������������������		 ������������������������������	

		������������������	
��� � ��������� ���������  

���������������������  ������������� �����  ���
 	

��� �   �  �
������������	  ����	������  �������������	
���������������������
������    ���� � 
���������������
� �������	 � ������   ������ �����������������	������ � ������
������ ���������������������	���������	
�  ��������������������� �     �����������		
   �     
  ������  ������������������		
		  ��  ������   ���  �
���������  � �    ���   ������  �  �������������			��� ��������� ���  ���
  �   �������������������������� ������������������������

�������  ���������
���������������	������� ���������      	
������	���		���  � ���������������
���� 	������    �������������������������
	  ������������������������       �	���������������  �   

������      ���	����������    ���   ������  �  �  �   ��� �� ��������	���������			
���������������������������� 		
������  ������   	
������������������      ������ ������������
���������     ������  ������  �  ���������� �����������������  ���������������������� ���������� � ������������ � ���     �  ����������������������������������� ����
���������	���������      ������������������������
������  �      ���		     ������  ������	��� ������������
�������������  ��������������� ��� ������������������������ 	������
������������������   ��� ���������   ���������  ���������������������	������������������   ������  �   ���   ������ �    ���� �������������������������������������  ����	
������     ������   ������		
������  ���� � ���� � � �  ������  �	���   �������������  ���	
���������   ���  �
���������  ������ �    ���������������
���������������		
������������������������		����� ���   ��� ���		
���	��������������������������� � !���
���  ������  �������  ,uӊ���������  ���  ����� ���� ������������������������������ ������������� �	���������     ����  ��� ��� ������	
��� ������  ���    ������������   ���	
���
��� �   ���������  ���������������  �		���  �	
������   ���  ������������	������������     ����  
���������������		
	���������� �   ���������    ���  ��� ��	 �����  ��� ������	������������ 	    �    ���			������   ���������������        ����
������������������         ���������  �������		��� ���������	 � ���������   ����   ����  ����� ����������	
������   ������������  ���������������������
���������������   ������    ������������  ������������  ���������   ������������		 !,
���������������		 ������������	������		���	
���������	�  ���   ����������	

������      ������      ��������� ��  �   ����������  ���   ������������������������	

���	���     ����������	
���		������   �  � ������������	������  ����	 �� ������������     ����
���������������������������		
  ������	

������������������������������    �	
 �����������

���������������������  ����������	

���� �������� ��������������� ���������������������������
������  �

 �	
���������

� �

��� ���	���������   
  ����������
������������
������������� ���  ������ ������������ �������������� ���   ������   

������������� �
������������������	������������������   	������������������������		������������������  �		
���  �
������������� ������������������������������� ���������������� �	 �����������  �������� ����������������	��������� �����������	
���   ������

���������   ��� ���    ���������	
���������������������������������������	���������������������������������	���������� ����   �� 
������   ������������������������������   ������������������ �����������  ������������
	 *���� ��������������������� ��  �  ����
���������������  �  �  � � ���  ������� �������������		

���������	
���

������������������������      ���������   ������   ���������������������	
������    ������  ��� ������	��������� ��� � ������  ����������������������������������	��������� ��������� ������������	���   ���������������������          ������  ���������	!������ �   ����������������  ����������   			
��������� ���   
		
���������	���������	�������� ���		���   	

���������   		 ������������� ����������     ������	
������������������	
������������������     ���� �   �	������������  �������������  �������   
  	
���    ���		��� � ���   ��� �����
  ������������������������������   ��� � ������  ���������

���    ���������������
�� ���������������	
���   ������������������������������������������  �	

���������������������������������������� ���������������   ���

���  ������

 ���������� �������   ���������     �  �   ������������		������
	���������
�   �����	
��������������������� 		������      ������������������������������������

���������  ���  �	 � ������ �  ���������	  ����  ���   ��������� �    ����������������   ��������� � �������  

 ���������� � ������� ��
������

������������������		������ ��   ������������������������ 
�  ���������  �  ����������
��������� ���������������������������������������	� �	

   ���   ������ ��   ���� �������	
	
��� ���	������"������ ���		
������ 
     ��������������������� �����������������������   ������������������� ��������������� ��������  ���������
������� �

���������  � ����   �� 
������ ������������� ����        �		 �����      ���	
���	
������

���
	
 ����������� �

��������������������� ��		���������


������ � ���������    ����������������  ������	  ����  ���		
 �������������  ���������������������������	


���������   	

������������� �   ���������  �� � � ������      ���������������

���	�� ��� �� �� �����������������		���   ������ ���������
������   	������#��� �������������������������������� ���������  ���� ������������  ����������   ������
������������		
 ���������������������� �  �������&���������������������� �

   ����������������������		
������  ����
��������� ����� ������ 			
���������������			

���������������  �	� ����������������������������������
   ������ ��������	���������


 �   � ��� ����������������	���  ������� ���������� �������   ������ � ������  �  ����������������������         ���������

���   ��������� � ���������������������
'������
������   ���
	  ����  � ���� ���  �  ������
	���������������������������������������	���������   ��� ����������������������	
���������������� ����� ����������   ����  
������������������������	������	
������������      ���� � ���	
���������������   ������������		���		
   ���	
	
������
	������	���%���	��� � ���������������������������� ���

���		���������������������

���������������   ��� �  �
������ � ���  � ��� ������	
   ������	
���������  ��������� �����������
���   ������	������	��������������� ������������	
������������   ������		���   
������������
  �	  ���������������������
������������������	������������   ������������������������������ ���������������%���	
���  �������������������		
��� ������������	���      ���������		������  ��� ����������      � ������� �����       ����  �������   ���   ������������  ���������������������������� � ���  ����
���� �������  ���   ���
���  ������������������� ���������������������������������

������������ �������
������������� ����� ���� ���
	
���������		���   ������ ������

 ����   
��������������� ��������������������������������� ������������  ����		������������� �   ������������
���    � ������  ����  ���������������   ���������������������������		���������������� � �����������������������������������������������   �������� 	���������������������� �  ������������		

  ����������   

���������  ������ �����������������������������������	  �������  � ���������������� �		 � ������ 		������
���������
���������������  ���  ��� ���   ���������   ��������������������� ���   
������  	��� ���  �  ��� ������������	������    ���   ���������  �  �  ������������� ���		��� ���������������������  � ���������  �������	
 ������������������   ���������  ��������������  ������� ���#���������������� � �������  ���		���������		���������������� ��  ������  ���		������������������  �������  �

 ����� 	   ������ � ���    ���� ���������� ������������������  �   ������� ����� ����  �	 ������������������  ����
����������  
������������ ����� �    ���		
��� ������������  ������� ���  ���������������      ������   ������  �   ��������������� ���  �������   ������������������������������   ������� ����
� �������	
	
���������� ���       ������ ������������������ � ������������		
	 � ���  �     �	
���������������
���	���  ������������	������		  	��� �����������������	  ���������		��� ���������������   ������������	
	
���		������	���    �����
���������������  ���

���   ���� ����
������������	���������   �������������  ���������������������  �� �������������������������������������	
������������������� �

   	
	
������	
	������  �    �   ���  ���  �      ���������������   ���	������   ���������  ���������  � 		
���������  ���  �������������  �  ����������  ���������������  ����

���������  � � ��������������
	���	��� ��    ���	
   ������������  �������������������		������   ������
���������   ������   ���������   �����������������������   �	��� ��  ��� ������   ���������������     ������ ���������	
������      ������������������������   ������������������	 �  ����   ����������������	

  		
������������

	���� �	������ � ������� ���		������  ����  �     ����������� 
������
��� ������� �������������������������  �������������
������  
���   ��� ����������������������� �� ���
���             		���        ��������� ��    ����
������������
	���	������   
������������������
���  �      ������
���   ������������ ��������	
����� ���������	
	
������������������������������  ����   ���
������	
������   ���������� ���"� �������


������������ �    ������  ��� � ���  ������    � ������� �� ���������   ���

������������ ���������

������������������������������������������	
������������������������������  
�������  ������
   ��� ���  �        ���� �  � ���������  �	
���
������������������ �������� ������ 
���  �  ������������������� ������������ �
��������� 	���������  �  �	
���   ������������  ��������� ������   ���������������������		
		������������������������������������������   ���    �������� ������  ������   ������������
������������  ��� ������ ����� ������� 	���������         ���  
��� 		  ���	 ����� ��������������� 	��� ������ ������

������������������  ������
������
	��� ���������������� ����
	���		
���������������
������������������
���  �� �
������������	���
������   ��� 		���������������  ������������ �����������
	

������ � ���   �  ������  � ����  ����		
���
������      ���������   ���  ������ ��������� � ���	
��� � ������������

���   ���������������������������������������       ��������������������� ���	������������������  ����������������
���   ���������	������������������������������� ������������  �	���������	
���������������������  ����� ������	������������    ������������      ���	
  ������� 	���		������ � ���  �	

������			������  �������  �
   � ����  ���     ���������  �������� ���  �
���
��������� ���      ���������������
������������
���
������������������������   ������	������
!���������   ��� ��  ����������������
����������������������� ������������
 ������		������
��������������������������������� �������� 		������		���  �   

���   	
 ������������	
���
���
	
������������������������� ������  ������������ ����� ������������   ���	
������      ������    ������  �������   ���	�������� 	������  �������    ���

	���
��������� � ���������			���������������	������������	���
���������������������������
������	������	
���	  �������������  ���		������������ ��

 � ���   ���� �������   ��� � 	�������� 		
������������������������������������������   ���������������������
���������  �
	���������  ������  �   ������	������������
�� ���������������������������������������������������			
������   
������������������������ ���������������    � ���
���	
��������������� ��� 	���� ����������������

���������   ���������������
������  ������������������������� � ������   ���	������	
������  	������      ���   ���������������	


���	
���
	���������������  
���	  ����������   ���������������������  ����

���  ������������	

���������	   ���������������������������������������	������ ���
������������ � ���  �	
���������   ���   ������������ ������������������  �   
 ��� ����    ���������������	
���� ����������  �	���������������    �������	������	  ������������������������   ������  ���  	
������	������������	   ������  �� ��  		���������		
���  ����    ���������������
	������������������������� �������������������	
�   ������		���������������������   ���  ����	
���������������������������  �      ���  ������������������������������  
���������������	���������  ������������������   ���������  �  �   ������
	
���������	������������   ���������������  �� � ���	������	��� ��������  	
���������		���������������

��� ��������  ������������		 ���   

	



       ���  �   		
������������ ������������������  ��� ���������
	������	
�� ������������   ������� �������������������������� �� ���������
     ������
���   ��������� ��������    ������	
���         ��������������������� ��  ������	��������� 
������������ ���  �������������  ���������������������������	
���� ����������� � �������
	
	������������   ����  �   ���   ���������	���������������������������	���������
������������ ���������  �   ���  ���������������������������������������

 ������
������ ������	���������������������	

���������� �������������	������������'���������������� ���
������  �����������������������  ������ ��� ���� ������������������

	
������������������   ���������������� �   � �   ������

���������������      ���������������			
 ������ ���     ��������������� �   �   ���� ����  ���
���		���������������

������������������
���������������������������   ���	
	���� 	���������������	������������������������������������� �������   ������������	
��� � ��� ��� ���		
	


���������������

���������������  ��������������� �����	 �
���   ���������  ����������  �   ���  ���������  �������  �������������������������  ����  ���� �   ����    ��������������������� ������ ���   ���   ������������������  �� ��� � ���������������������		

��� ��� �    ��� ����������������       ������ � ��������������������� ��������� ��	
������������   		���������	������  �������   ���������				������	
������������������������   ���������  �   ���������������������������   ���������  �
���� �
���  ����   ������    ���������   ������ ������������  ����
���  �  ������ ������		
���������		������������    ���� ������������  	������������������������������������ ��������� ���������   ���������   ���������� 	���������	
���������  	
������   	� � �	

�������  �   ����	� ������������������������      ���� ���    � ������������
��� ������������	���	������������
������������	
���
���������
������   ���	
��������� �����   ��� � ������  ����

���������

���������������
���
��� ���	������� ���������� ���	������  ������
������   ������	  �������	
�������� 	
������������������������������������������       

������	������������ ������������   ������   

������� ����������������   ���	�������� ������������  ����   ���  ������� �������������������	
��������� � ������������   ������  ������������������'*5������ � ���
������������������������������ �� ���������������
���   ���			��������������� 	���  		�� ������	��������������������� ���   	���������������	
��� � 		���	��������������� ���������������������������		������������������������ ���������������   ���������������	
 ������	� ������������� ���%'2���	���  ��� �����������   ������		
������ ������  �����������������
���   �����   ���   ������������   ������������������		
	
������������������
������

������ 

 ������	���	  �������������		
���������  ����  ������������� ����	
������������������	���
 � �  ���������������������������	
������	
���  ����������������  ���
����  ������������������������   	
 )���������������������������

���   ��� ������������������������������������������  �������������������������������������������
������		���������   ��������������������� ���
������	
	���   ���������������	   ������	
  �������  	
��������� ��������  ���������������������������� ��

������������������		  �������  �  ���		
������  ������������� 	���	

��� � ������������������	������������������ ��  � ���������	������������������	������������	

��������� ����������� 	���	���  ������������		
���  ����   ��� � ��� 
������������	
������������   ���� �������������  ��������������� ���������������   ������������     �������	���������������������������������		������	���������
������������������������  ���$���������������        ����������������������������   		  ������������   ���������	������  ����

������	���������	
���������	���������������   � �   ������ ������������	

�� ������	

�� � �������������������   ������
���������������  ���  �   ���  �         ������������������		
������������������������ ������������		������		������������  �   ������  ���� ���������������������


���     ���	������    ��	   ������������   ������������������ � ���	
���   ������
���������  ������������    ���������	���   ���������   ������
������
������������������	���������������������������������	������	������         ������������������������	���   ���		������������������ � 	
���	
������� ����  	��������� � ���   � � ��� ���������  �    	������  �      ������������
���  ������������   ���������


����������������������  ����������
  ������     ����������
��������� �� 		������������  ���������  �	���������
���   ���
���
���
�  ���  �  �	
���

������������������	
  ���������    � ������������������  ��� � � ����������  �������	������������'���������������������
������ ���  ������������������	������������������������������ ������������������  � � ������������  ���������	��������������������������������
���������� �������
������ � �������   �������������������������������  ������
����     ���������������������		������  ����������������������  ������������   ������	���������������������������   � ����  ������������������  ���������  ���

 � ��������������������������������� �������������� ����� ��  ���������
���		������������������������������������������������	�������������������  ������ �� ������ ��������������  ��������������������������������������������� �� �� ��� ���� �����
������������������������������ ���������  ���������   ������
������������   �������������������������������������  ��� ��������������"#.��� �������������������� �� � ���� ��������������  ������
�������������  ������	������ �����������	
������ ��������������������������������   ������ ����� ��� 	���������� ����������������������������  �������     ���  ����������������	��� ���   ���������������	
��� ���	
��� ������������	������   ������ ���  ������������������������ �����
��������������������� ��������������������������������������� ���������������� ����� ���� ��� ���

������	���� ����������  �� ��� ������ ��  ������������������������������������  ����������  ����������   ������������	���������������   ���������	
���  �   ������  �	���
����������� �������������������  ��������������� �����������   ���������  ��� �������� � ��� ���
����������  �� ������ ��   �������������  ���  �������� ����������������   ���������������������  ������������������� � ��� ����������   �  � ���   
*+<���   ��������� ������������
	������   ������������������   ������������   ���������   ���	���   ���������	
������������������������   ���	
���		
���������         ������������������������   ������������������   ���������   
���	
������������

������	���������������������   	
������         		
������������	������������		
������      ���      ���  ��D���F��    IEND�B`�DQ  �"��MWϚW$Q  inv_expand.png �PNG

   IHDR           ���   	pHYs     ��  
OiCCPPhotoshop ICC profile  xڝSgTS�=���BK���KoR RB���&*!	J�!��Q�EEȠ�����Q,�
��!���������{�kּ������>�����H3Q5��B�������.@�
$p �d!s�# �~<<+"�� x� �M��0���B�\���t�8K� @z�B� @F���&S � `�cb� P- `'�� ����{ [�!��  e�D h; ��V�E X0 fK�9 �- 0IWfH �� ���  0Q��) { `�##x �� F�W<�+��*  x��<�$9E�[-qWW.(�I+6aa�@.�y�2�4���  ������x����6��_-��"bb���ϫp@  �t~��,/��;�m��%�h^�u��f�@� ���W�p�~<<E���������J�B[a�W}�g�_�W�l�~<�����$�2]�G�����L�ϒ	�b��G�����"�Ib�X*�Qq�D���2�"�B�)�%��d��,�>�5 �j>{�-�]c�K'Xt���  �o��(�h���w��?�G�% �fI�q  ^D$.Tʳ?�  D��*�A��,�����`6�B$��BB
d�r`)��B(�Ͱ*`/�@4�Qh��p.�U�=p�a��(��	A�a!ڈb�X#����!�H�$ ɈQ"K�5H1R�T UH�=r9�\F��;� 2����G1���Q=��C��7�F��dt1�����r�=�6��Ыhڏ>C�0��3�l0.��B�8,	�c˱"����V����cϱw�E�	6wB aAHXLXN�H� $4�	7	�Q�'"��K�&���b21�XH,#��/{�C�7$�C2'��I��T��F�nR#�,��4H#���dk�9�, +ȅ����3��!�[
�b@q��S�(R�jJ��4�e�2AU��Rݨ�T5�ZB���R�Q��4u�9̓IK�����hh�i��t�ݕN��W���G���w��ǈg(�gw��L�Ӌ�T071���oUX*�*|��
�J�&�*/T����ުU�U�T��^S}�FU3S�	Ԗ�U��P�SSg�;���g�oT?�~Y��Y�L�OC�Q��_�� c�x,!k��u�5�&���|v*�����=���9C3J3W�R�f?�q��tN	�(���~���)�)�4L�1e\k����X�H�Q�G�6������E�Y��A�J'\'Gg����S�Sݧ
�M=:��.�k���Dw�n��^��Lo��y���}/�T�m���GX�$��<�5qo</���QC]�@C�a�a�ᄑ��<��F�F�i�\�$�m�mƣ&&!&KM�M�RM��)�;L;L���͢�֙5�=1�2��כ߷`ZxZ,����eI��Z�Yn�Z9Y�XUZ]�F���%ֻ�����N�N���gð�ɶ�����ۮ�m�}agbg�Ů��}�}��=���Z~s�r:V:ޚΜ�?}����/gX���3��)�i�S��Ggg�s�󈋉K��.�>.���Ƚ�Jt�q]�z���������ۯ�6�i�ܟ�4�)�Y3s���C�Q��?��0k߬~OCO�g��#/c/�W�װ��w��a�>�>r��>�<7�2�Y_�7��ȷ�O�o�_��C#�d�z�� ��%g��A�[��z|!��?:�e����A���AA�������!h�쐭!��Α�i�P~���a�a��~'���W�?�p�X�1�5w��Cs�D�D�Dޛg1O9�-J5*>�.j<�7�4�?�.fY��X�XIlK9.*�6nl��������{�/�]py�����.,:�@L�N8��A*��%�w%�
y��g"/�6ш�C\*N�H*Mz�쑼5y$�3�,幄'���LLݛ:��v m2=:�1����qB�!M��g�g�fvˬe����n��/��k���Y-
�B��TZ(�*�geWf�͉�9���+��̳�ې7�����ᒶ��KW-X潬j9�<qy�
�+�V�<���*m�O��W��~�&zMk�^�ʂ��k�U
�}����]OX/Yߵa���>������(�x��oʿ�ܔ���Ĺd�f�f���-�[����n�ڴ�V����E�/��(ۻ��C���<��e����;?T�T�T�T6��ݵa��n��{��4���[���>ɾ�UUM�f�e�I���?�������m]�Nmq����#�׹���=TR��+�G�����w-6U����#pDy���	��:�v�{���vg/jB��F�S��[b[�O�>����z�G��4<YyJ�T�i��ӓg�ό���}~.��`ۢ�{�c��jo�t��E���;�;�\�t���W�W��:_m�t�<���Oǻ�����\k��z��{f���7����y���՞9=ݽ�zo������~r'��˻�w'O�_�@�A�C݇�?[�����j�w����G��������C���ˆ��8>99�?r����C�d�&����ˮ/~�����јѡ�򗓿m|������������x31^�V���w�w��O�| (�h���SЧ��������c3-�  :iTXtXML:com.adobe.xmp     <?xpacket begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/" x:xmptk="Adobe XMP Core 5.5-c014 79.151481, 2013/03/13-12:09:15        ">
   <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
      <rdf:Description rdf:about=""
            xmlns:xmp="http://ns.adobe.com/xap/1.0/"
            xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/"
            xmlns:stEvt="http://ns.adobe.com/xap/1.0/sType/ResourceEvent#"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:photoshop="http://ns.adobe.com/photoshop/1.0/"
            xmlns:tiff="http://ns.adobe.com/tiff/1.0/"
            xmlns:exif="http://ns.adobe.com/exif/1.0/">
         <xmp:CreatorTool>Adobe Photoshop CC (Windows)</xmp:CreatorTool>
         <xmp:CreateDate>2016-04-17T08:16:45-06:00</xmp:CreateDate>
         <xmp:MetadataDate>2016-04-17T08:16:45-06:00</xmp:MetadataDate>
         <xmp:ModifyDate>2016-04-17T08:16:45-06:00</xmp:ModifyDate>
         <xmpMM:InstanceID>xmp.iid:57acc758-111d-0a42-ac7d-4072e6841ab3</xmpMM:InstanceID>
         <xmpMM:DocumentID>xmp.did:7aa4e8de-9454-d54b-88e7-45be2052df79</xmpMM:DocumentID>
         <xmpMM:OriginalDocumentID>xmp.did:7aa4e8de-9454-d54b-88e7-45be2052df79</xmpMM:OriginalDocumentID>
         <xmpMM:History>
            <rdf:Seq>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>created</stEvt:action>
                  <stEvt:instanceID>xmp.iid:7aa4e8de-9454-d54b-88e7-45be2052df79</stEvt:instanceID>
                  <stEvt:when>2016-04-17T08:16:45-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
               </rdf:li>
               <rdf:li rdf:parseType="Resource">
                  <stEvt:action>saved</stEvt:action>
                  <stEvt:instanceID>xmp.iid:57acc758-111d-0a42-ac7d-4072e6841ab3</stEvt:instanceID>
                  <stEvt:when>2016-04-17T08:16:45-06:00</stEvt:when>
                  <stEvt:softwareAgent>Adobe Photoshop CC (Windows)</stEvt:softwareAgent>
                  <stEvt:changed>/</stEvt:changed>
               </rdf:li>
            </rdf:Seq>
         </xmpMM:History>
         <dc:format>image/png</dc:format>
         <photoshop:ColorMode>3</photoshop:ColorMode>
         <photoshop:ICCProfile>sRGB IEC61966-2.1</photoshop:ICCProfile>
         <tiff:Orientation>1</tiff:Orientation>
         <tiff:XResolution>720000/10000</tiff:XResolution>
         <tiff:YResolution>720000/10000</tiff:YResolution>
         <tiff:ResolutionUnit>2</tiff:ResolutionUnit>
         <exif:ColorSpace>1</exif:ColorSpace>
         <exif:PixelXDimension>32</exif:PixelXDimension>
         <exif:PixelYDimension>32</exif:PixelYDimension>
      </rdf:Description>
   </rdf:RDF>
</x:xmpmeta>
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                            
<?xpacket end="w"?>�(�    cHRM  z%  ��  ��  ��  u0  �`  :�  o�_�F  0IDATx  ��I
		��	�� � ��    ������������������������������������������������� �   ����������������������� ��������������
$������ 	����  		������ �� �� ���� �  ���������������������	�������$�  �  ���	���
��   ���	
���     ���������������������������������������  �����   
� ������� ������  ������ ������������������������	��� ��������������������� ��������������� �����������������		 � �  ��� ��
� �� ������� �  �"	��������� ����������������������� ��� ������a*[+	� ��� ����������������������3].H#��������������������� +	;�(���!NF,����������� ������&
Ub@�������������   ����� ��� � ������Av��	������+	������ ��������$		/��繵�����@!��������   ����� ���&� �� �  ����������#+W)��� ��� +
]P3����������' �������� ���� ����!
�������  ������[2���������� Q=#������.	PT2��춻���!%O��������������� �  ������������
���Z(���������A;#���	LS2��멳�������&%V5���������
� ��������� .
w0��!����������B!#���������:-Q	%������  ���  ���  !	����� 
f*����5
����������
���������A7 N�����	��������
��� ���:	   R!���������!,:������������������I?&M�
���������e2��������   ���������5�����  �� � ���������"(��
%���  ���� D31����������� �)(�������������   	 ���� ���\*����������)6!?	����� F5R����������6A%B����������������
����  
 �������� ������W-���������9	+'F#�	���������.6L9 ������������   ��  ���� ��� �  ������� ��F%���������
7
� ������ 4;"N6ϰѾ����� ���     ����� 7���  ������C�������������������	5>#D(ٻ׽�������� ������������ ��  :    ��� ���	iB%���������������?2N��������� ������ ���� ��  ' 
������  ���  ������O����������8$T	��������� ��������  �� �� ��������  � ������  ���������f)������ ?'X
������   ������  ����  
������  ��   ��     �� ������ 	���d��X!��������	�������������� ����������  	 0    ��       �� ���A	���������	    � ���� �� ��   	������+���   �         ���   ��� 	 ����� ���   
 ������        ����  ����� �� ������ �� ����������� ���	 �� 		 �� ����������  �   ���� �� �  �  
 ����� � �  �  �  �� ����������  �� ���   �  �� 	����  �   � ������ ����� ����    ���"������� ���   �  ������  � �� 	 ��  ��     �    �� �� �  ��    ����� ������  
 ���   �� �  �  �   �� 
  �� �� �  �� �  �  �� �  �  	 ����� ����       �����  �       	�� �   ��   ��%e�3`z�K    IEND�B`��  P�+�MWp�W�  MaleHair.dmi �PNG

   IHDR   �   �   y�z   *PLTE���Gs&�=;�ki㊌&)&;88TYY������   ���L/T�   tRNS @��f   �zTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT S�(5%7����8#��D��3%�����3�((RM�I�2u��9)'19� ��$5���
�~.`� [�4T/8  �IDATh��=v�8���f�
�Im�Dr6`�H�>i�)]�`��t5�G$3u,�;�ur�E�#	P
h�a���7ɑ ��p��C�?�,l�ý�I��cL,��3L��7u�:���Щ:���z�Y>z������'��ر�+�Խ��ҳ���\^{�x����{}U5P�`�%��gU+��M�6�Cw�D�"��=�|͟2���Jx;�%w	��|��L��vv	k~ǥ�I�[F�!�9� ,���r���!�H������ֆ�c(w�=zQ�a��l���P������ؓ�)~d`Hsm��`�������X$��E/���˽ W0a��G�r(�ΈG�P,I=ǁ�b��C�4݋�W6pGƹG����~;3Ӓ	�+&�19���C"�Єc&&�����۲1B�U\xb��E-�*
�mZ����;:��td�_�#l�!"#3��-�-d"&.#�_(�6�m��M0)Ǌ��,	�f����,����bmq��?W����e1A�!�&,k��;c�E!�������/��} dRBF�S����������ɠp�{/�X/��k�,��"��oC㥆���#�pI�����'���sm�`Gl��N�:uj)M��uy����A���T�z<X�k�`ͯ˃�_��6�~mT��<X�k����Aկσ�_�?��Aůσ�_�;��ԩ�ϩ��~����s�x!��㝃�O�,�Z�c����~�y�tœ��2􂇌�WUG�>f1gI(�M<�O���2Z2���Eq���<KV��E_��y0��$����	zQ��VY�D�^�OY��F&<ȃ�x����c��<�+�8�Q(����V�i�-D�~�p�����e�(���ʆM<	��l=g"A�.�(�y(����[h�A8����6s� �ϗ�e�9+#�,b�?ۄ���&�y����d=d���b��B��/`�f��j���,�����P��l6+�ө�M����(�ym���!���<�Y��7b<	� ���EާM<�����d��v�&�������ȃ�rg�j��e�6��W=�M<8(}��c�硟_XQ:��쿊�yp�|n|V$����Go[�����������n�'��?��v��lѩS���� ��DKT��h��0ӒU?^��(�EhɃ���.y�ɢ�hŃ5����x�[�%��^�@Wa*�%��h��>X��HԒk�^�2h݋��<���g�h��'��Z��GA��A|gSq��xP���m0�o���myP�����y����%��%�mn'��h̓�_L�+�j̓�_L�L�DkT��jwk峑��z�HFn�����ER?Ń�uu<ةS��H�k���z?=�I�k�����y�&]�I�k[����j�*m�I�����t$܏�|��/��u<ةS�c�_R=�lQF��    IEND�B`�T  ?��MW��W5  MaleTorso.dmi �PNG

   IHDR   �   `   ⤊{   6PLTE���@EE���afk���xR=����xT   ¦xdLL8  s&�=;G�kiE++���   tRNS @��f   zzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT S�<#�$�8#��D��3%�����3�(17�6���$V��:@ȥ�����
 ��9.��  'IDATh��X�� ��n �p��/�cڮBz��'���R�����Cp8����_@���4�1
�s��9N��n��{�+/����_D^��)�w�(�2a@�3�6���YE��0�}��q��=��H% ��r"@b$YU��{����AH��&��HӪ|` w�BQG�ˢ��4����p������p6���@.�ND��D�� �����H�lۖ�$�Oư�r0�o|2��ጌ��T�?�̭ɓ҉A)9��F�o�2����U8�Y�s�-[W��[�Q=��c��G#�A��G��֬�����:�L
���K�uG�:��A��@���(θ(z�[��W�(�֦�2� �R�w���D-O��Z��^�h����X�-�9�����"ֺ��+mv� 7��D5�zuՖ+⌧&|�x'��uq����
s~�l	���ET� t�<���4�?�5]J-A��݄W����k�wo�����r8����|>����|��>>>p8��������|��>��@��@��|��3j�+�m    IEND�B`��  �LN�MWΖW�  minerals.dmi �PNG

   IHDR   @   @   �iq�   }zTXtDescription  x��ʱ
�0F�9�)~t/�u�R"�A�A��dh�����C��t;��a�3���`)iϰ�O2g
a�~�����u�.ʰh��2!I�EGf��˵o%���0矴�0;���eY3�1I  �IDATx�͚y��Uy�?{�����=cr2'��0O.��k+�4`]�V�^�K��jkA�j����J�miK��Pk�^���Z�`D!��2�䜜���ߴ���$��m�]�]�����~��g?�����4X^��xj�ay��1ը�җ����Z�E�7n�c�L{�[�8>���DQ%W�Ҿf�'����%~��?&���������'���^�V�DP,�9's��"`iݹߦ�˶}����OE��=�~S���-O�M�1�}u��_��ۓ�x��-7�QXH+��\��	�m4�|,�@t�rc�>qW�Ŭ��8�x�3�k�&ɷ�`4��R���"}�"c�]�I?���ǀ�"-�����㔥2W,�\���oƽ����  � C�Xң���x�����\w�#���>q�9�y����:������\޷���o>�쵥U+M�3�?#_���z�^;fݺ�-7^7v��]�g�O��n��e�%����7�R����ŹB	��-,����-̳g�ct:-R��޺j��7���v�Vu*9/h����ι%x�w�,�|uժ���6�ƺ�U����jd���{��R �b���ny�Ͻ���#����'!��=��B02�������۱��z>����	��\>�t��(�%�u
y�?#?t*9/h�U��N<�7y�ś��}F(Ǜ82/�{ӫQ�"O>�$�V�P*�Z>�ʁ`�|=�����ڱ���ׇ?.�hu�dI̎���|��a����+����:n[~�Xc�Rb��Z�bmNm�ϱ�]���A��P�/ �[���*+�/T�g�B�u��W~�f�;�ub|�����y��~��ň\���_����p������l����^t�(:z$K�DH\ס�8O�@*�4Eb���:`-i���1��H@
 A+S�/�����������+��H)Bc�5֠��<��x��Wa�mZ�67��� zq�K����ZW_<������ڢ\��b��v��!)x�V
ZgH	��@g�8�0:#M5B�K��e�_}��{��}掉���#�~�^vŹ�$Z�T�R����D	A�aab��J)\��Б*W�����ꡀ��+1Pv�}?pY�[�����k�C�v���a+�_�/z�.�n�L�6�p���j� Ge(8WZ\a�%'��f�fk���e��w�����石��6��ȑyj�.�(0Q�P}���v���u׿���Z�;���b���yz���Y`�k.�TY6���&��hi��rP�"���rWKGz�r	�h�%1��v�hg��
���(ǥ��hG	Q&0,Y� <iP�罿r��}��g�œ,6�U�5�����g���u���wwR.�,[�h�T_���������8�#)�<�n�+��׮�ӊ�Zh���|���lC��m��O�� �X麞3�a��sX����E��	�P|�빤F��K�h������q���X"#*=-��)������Gb�o���w������?zOIBo駩�5b���s$BHBߣ\)Q�������͇�p��n�G�dS�n%�������������z�4־Gb��c,�㠔C�ҏ����X�R�#�{H?G�p�X�',IK2��GC�H�`ݿ�� ��-���GA7�l���*Q'f�d�9�E�=�0�쁀Z7�W����� (�.����3��G�<�K���{�ũ� <�|���е�,�������בC�n� ��C�%W*�q�CJ��&1�vG�X2}WZ<i���q�g�zg��H)	}a3�m��o��j'FbXl�x*�Xh�{8� 3����Z=�
ҬK./q� �
�!J3ډff��gccc�?tbw��՞�{���X������5s���CS�ęA�>�+�p��Cw�hD�
:�Z��U_Z�B�%�����9(�ߘ&	CE/2h��������F9��zcifpI��q�5�G�R*2��	���R���Qf9:ۣ\��7����>>>^���׈U��c�%%Ƃ�%���֒ Nxr�c�b�P��A;�@	��D�]
<�����|�����`��-��Q]l'��6�wM�-�	s��X�Ts`����
��Uy��7�lG4Z1g���_��#���.�Z�R,6SW����G��?��a"q�]#^H�����(��B�����B�j�Ȭ��m�"�cBXb�������PqL����j�����H�����e���KҌ4�H)X�v���p��#V�1if(zx�@kh'��1�������+��;4ϊ��t�$3���p]�H�G'1 ��������=�������Z�`Kj�#����,��J� X�1�H�}�������Bd�, �,���F�������^Jd;;�Y?�O�a��/�xr�$��ա�Mٲ�@��W�t�AާeT{����<S33�?����c,C9hD�v��ϻ��=~�t�%}y�܏����_�K8|),�4SK(,� ��0n���k��J
��H�!���b�C/Y�B@�1�V�/v�J:Fl~�$;vO��ǹ�W�fE���+��G��)���H2��3F�ⲍ\x�Z�8��h��.�ܷ�����q�9�2�mS��c����_��;��_�MG@���w����#:Q<�������W�	�@I����e�<=R!1B��� s%���!Ӑd�0�֒e p���4�L1�fTS��%>�:�f{��w��+_�'��;?<�|;#�!$�^F/�\t�Z�޴�,Kq=��p?�BW	�$#'RBG �u����P�Fl:{#A��kV�l3c��i���J�
�`��*�� ��HK�M�!�Ĥ���FQ�8�G�)\a�t:�^�>:�z1%���]MW+��P���~z��ݸ�;I@��oRp��"_��S4=��<Ľ����8���:B,%? �F������Z�v՞e��r��/᪫.$D���`[�:��ZD9T�8���l/�,�51�U��~��n��Ȏ{������@S+z,�$��Ɛj�+-9eH����R�����
61������Y�ga���
 g��}�-9g�5QOP�,�#�YPR�%1��*��<�|!�=S��zd�eZ9����'�L������G��ń�"p%�v���,��W���o�����/������c���$<��3	B��.�����Ʉ˨�0)<J*!�Zv�\��#'�e���/SJ�a�Hٗ8�K�N� uvj��+;/:��u�}@%�C�p�7#��[xr�A�ܼ�P�G��;d�%�+*E���K����lຒ�/i�����GA���ņ�6��+�oF��7Bi�LiE�
�����Tc-�0T3�#52�/"��m��=�2'cO���E3�
��(,�4t��b@�������md�"�IS#���ޱl�h'�W���c�5J�<R
j�6w�����)�J�8�R�`�H�D��γ�
F�R�e%���)�'j��a)BX�Z����#@
��F"�@[�H�,�`��7Ǔ�HÎ�%1�/cčQ�R��*���J+R�������PKٕ9^Q\������y�[
m���|����IbXh&<�o�n�90٦�h����	R@�ch�|�8MS�t��_i���g�b��\���f�����nJ�x��W~��T�&6�~7c��XzV[IQBa9�ͨH툥�@$��΁�to�X)H��Q���<�V��X��(�)�B�.�#e��x���5}WB�M�h�R��LU{,�2chv3� �g��3����^��2��Kf��-U�M-�{H!�Nf���e&qh��N��X3�Դ$CPK�Z��ZF�Y���Y�ZbK�R���_��g�|e򁃒�(3�.��RM�'�c3-Zݔ4ӔB�fdh�R<G1X�S�#BI
��R�ي�Á�<����ɶ�o��|��x�i���҇6��BAai�#��L氐��憰�d�ya�S�e�f�1h+N���b6�z�r��a�xڜZA����������ccc�{�w����%����#�~8A�P*()iw��Ǯ���t�_	4g��C�\�vNFw,����jbZ��<<:>>^���׼*������8�vdAX�K-u�� ��%�;�P��Ч2"+�wR,г�49)��0�,����4�jNݛ"+�<�<k4666��s�����+��/ =O�ł����ьY7Z�u��{�ns֪�F�B7��b��=ǒ��������G�����U��s�s��_x�5�ja���	;2��S���J�#v��m���
���AG�Ђ�c	c%gy	B���ع��cR�[�m��+{��������>�t}�K7��#�(��l���-�ȃOw?�M�Q)Ŝ1��E���7_~Q3������jy�b&�ߑ��8�)آ��|/@�9���e����'���g2�Xj�7�}��[�/z8z��]Y\1�)*��|���21��k!�܅k�����]?���`�7^��&��Z�U�M���~���!`_ ��K+�������y������#�?�t�T�u�=��˯�����b�cM����}�C6.�m�{ӝ����c����l� 7_~��u�=��˯9�t�t�Gp��{��2��Wl=�<�z���=��[I���%~*������}E�|����Z��©�� &����G�XU��{��`貍����
�.aӡ�}d�m.��/��ܺ��_Yy�>�c��{��a��u��z����.�r#	p�`����f;�I[9�����4�r�ͷf/��3p�}�)-`v�"�Q\��x�H�y��tW�4O��d6��e��;uV�]��ec�MŠ���]���oy���w~�'� ��%����$��Kbd������v��'�T�	��S�XN��F�`����:	a�g���"�L������^{�k�w0�_�!�ݷ�ǻ�� ��k�3����q?����t��!._�"���):IH��E8�k�]�G1�7Y������U����������ޏƳ|���������yAa�����R_�bpC�˷�OL?ʆ!C����	��3�3~x�~����rt�t�=�y�F�������������t��g���k?|�+�W_����Bu���|oG�N��g�Q�Cߥ�w9Z�CI}O��Y���3��"Jy�a'tY~�2��@X�Z�DH;|�4���<�������Wo^_���D��������쉨O�L?���$����y�Ot'�u�K�5�8g���Z�7X��C9����/����S׽��.���=p��5g�FGB�
��>��ӉhwS<7cp8`��"�Z���bS�m6�A�ί�z�E{1�~,A����x��:��Li*�����S�����S�gB�����|�z�40RI�]ɖ3�ĺIk���]5�y���E8�$���C}���t
ÃL?�`�7&i׺��A�6�/+��~y�N�A'!�����GN�� ��o�^\�����H����A���K����ނO'�151y�Fa�B�K�4�c�>H��^�����u[83��B���|�Ju_��g�
Y���G१���-ٰ!��Tr���8��%'aˊ��9�=�I ɨ�O쨓�Et��:C���ӷ�Ǫ��2el`)�	:3X)0��D��2��-�[y ��֍����C3�	<��t�#Ӌ�Lq�UC�<�c�\Y��?cph�.{���zt��@�k�X;���4O�p.n_�O�hϷ�~��SX�ۅcU���ӭ<�s���(�n�`TB[�~�����O�|�\�[�#��3\|��љo��3��D�k�u��Z�ؗ'�BIiM	�l1��J�`������M��MO˫��z��t�^z�ƏTr>���g63������|��S'�8\�U�~�5���<���}�r�{��й�$��/�T'L>8�՚ʈ���L�R(i�5�ָ���$@>�f��yj�EG�qd%%�_���ְ��+a�C�E�wp��d���	�L���Gz�hOr�H��kH�)�5%��G�����Q.i Es�FiDPYSD9�?��8FZj��MC�[ ��s��A&����6��l��xh��r��|77���x�z����,��Xۿ�8�tk-�L�YԔF
�}C~ ��� �����D�r����������XYI�x�*J����N�u�$A��c���|�v���a�ȴ���@)��}����&ɏx�ՙ|��zTV��)B���.��:�PNY@�� ^�gc�>���K�s�Sg��˸⼋�����h���p�צ8xT���U��ӏ̂5n�#(z ,q+�3ՠ�cp�n	t���.�/�,�p�2G�q҉��I��Z��0�c'�>����>��)u�.���Y��+��ߦ=W#5��0t��8�@G�R%جF�� �f`A�fdq�N�T\c[\KH:�����&�+.��S	a1��(�S-f�"��w-�����$���&�j�N�d�e���Q��IO\[��~L���8�G�NjY�|�t�dQJ�sX;���,u�u����sl�i��R�t|�1a�#,�[�*#_!�&%KBj����8T��������EC}r�Ҳ��^�}:��љ$ߟQ��!_qpA����%An Gi8@H�6�M�b�qK}����ڤ=���B��EZ�"�CX��#��P
�5�I�i�x�i��_��Չ��i���\������*�+m�*��ѡ8��T��
�w)�:�²uXB��W"��)Jv�RIK�
�&n�щF�j�Z�x�	p ��j�ܿ2<K��r��}�s��t���=>�)��x�����y@ Ey�Q���Z��psE�,�!��h0i�t��l���:��*s� ƿ����z�I�7�p0f���ʳ�� �d�!R�8i�Z]�R�L����P?��Q�hS?�0���=�"K4�HA@�Ԧjwdq�W���=
��	ƭ�j�s��r胳{��{!n����"I���m0�0�o���P*�x.�j�,F(h�G�iԼ!�|�����ƨ�E������:����s&C��gv=ؗ����ͫ^���a���;)���;�f���LW
���,��*-�Мn�&�Ap_kv�k���J�,[D��X�{|||��NwW�Gc����k̚4NF����=`�?���T��t{�@����gN���M�����K��$    IEND�B`��.  R�Y�MW#�W�.  organics.dmi �PNG

   IHDR   `   `   �w8   �zTXtDescription  x���A
�0EיS�/U�ͦDJz��	$�$C��wᮥ�����^����GT���I��%�.W��آĮa�[,!3�A���K��+�K%6 �D��7ٖ��)b�`��!�<܍�q����i���ƹ�g�U���P�3d�l�S�v    IDATx��}wx\���;��ݮU�Ž��W�jh6���	Bq�G ��&!��b0�)F+SeYe�ھ{����,b�U��}=��{�̙s�y��9sG$��j!�HO6Wm��"*�V9�|�`m��]��_=뼗�-� 6]G�b�Sn��rV���Zk��$'7���j���K�?�K_FJM3	wլ����a�AּV1�����)9o�7�_�R��k�Ь�C��-'�_�  Pj�pr��:�ll��Y��z�x�}ݸ`�D�_U�����)�OWF��I�.����%�ߗK�}� �Fᔅ
��ߊB��n�B�n����^ R�����]�eyn��������]C^~���0���{�v�q�F%3^�0��P0��ERf��Rνz����J���� �\��54@7��]���S���ꆍϖ%��c����زE�ˇ߈O<L),�j�C�5���u0
���ܫE!�gc�x��L��ٌ"�f�"3�Ăꠥ(
	���8zx��:�W��iC�2�B�(~������2����Q�<��Ն��4~kh�ğH����f���"'G¦u�"PV.�Hf�9U�6~lGy/��G=����4%/+5
wR�c�a�����T�ѩ洵�9�6���`�����FM_�m�4��Gy�iS|gH����hZ���YćJ�C%g�s���˳<�c;���Ow�.[҉���(Qಅ,��)���P�p0 �GW�X�0����K����k�lۿ1F+�"��X�~�R�|����ȑ� :D�ظZM�<��nh�����Q �G���l�p�p�@���Ǹyg͇c�|�}!�Y�]��ͫoĘh��v�����t�``p8@6�̀8(�`�$Y�^��Gl�`t��0p
x(����m���s��%X�;�@���o��Ж���#w8'��P�mIc����I�&3�-;�.f��G}�ب^W�E!�擓ˢyn����>醚t�6`Y��_����c�45pL�Q�o�Y�7�	`+���4�P����}���E�x߅A�����/����"�`�1ʈ(q�Ft<��Nd��^�喉��&Mb=�\ 1��qÝ�ħ�/� +���'�i����_�㻦O;[�n�qTΨ@������s�����|�)�������fs5X��b$�*����wa��c��]�t�S]��qPT�a��,T+Y���r'�H�{�/ ;���q$��Q��tY4Ǒ�\=���T�P�ٯjo�k1�WV���{�g1/���,A����c���k�ډe�?�[�(Jm0�;��q���u�Յ�+�;�T�S&8\�'fa��8�~-��R��B8�'�3�@���Ygb���Z�"YǯnX����,ll������ee���1ܐ�w~%���۴���b��~|\Z�v�۩T1�g��H,�`�`������t���|��#��
q"���g�����`b���7
���7�q5:�'�KG�y80Kg8��|�wn!`�l[�c�h�m�CÖ4�3�F�xF��q������@�����Ɓ��Z�0�gU�/v���ʹ��H��|�y�FɄ1�z�m&9	L��c��-k�	��Û�&0,�&���.�;���`�)pߑ������O^V)��n X�F��(wV�AA4b\_$�q�HR�2-i#�Ԩq>���	K��&(^��+��� a�P�� ��G0l�-<�򓽦G��vA���Pj# �ǃ�GCi�>����X̼���H�D|g9G��y�lN��,dt� �,�;�9�Jx�=���ζ�0��L�/�mX����c���K��3"��sf��k��w��Z+9!j�����_U���+ֽ���3q�Ƕ�c�\�Gx�,OH�\j�&9}�{��#�vY�J%,i�1�Ǐv�3_���ӭ.A(^pܻO��g�ah/��"J�ѭt,��챸�����7;�LR�0��>���̴��]Q@��e쵫�;��q�w�����?��vz��N����"�;���J��Fz�P���OET�+7?�lAu�z�`]�7�N���h� 4�a��RP-i�|�|�`�|��`0�j��cC��>�.�a�*b{��}���P��U:��K�gܯLs�ش��`����*=r����s5�0o�IJ��8!�fsv�GH K`�)�R-�}��	S]0eJ6�j�L��c|�S³�+\W����]k�ʡ���5T����<��b*u_�)���(
��^n-��لb1/}��ol�1�n��8��b����	$@�+��ꐨ
ka��5��v�CR��L���U[���*=뇢]�c:������7������v����C�9������K[�t�w��(6���M��?�s�,��|��C��J�t�w�`u��)X��������C�9�i�H�z_��C��␯}T9�^j�u+�H�0��{z�WE[%A(���w�ڟ�����~`�"E��]�U#���"�Ok9_��f&L�*��m	 ��V��Xʃ��s­��נɇs)�9�S���n|�T�ݺ�;�ݽd6�y ���Fn���O�d��Oo�s5��\vآ���g��kj�����Y
9�:P���K�'*�q
͜Q0�%����H�����A���$�	d�����w5�o0��o���'\�t޵i��G
���W��{���`BI^N�X�m����ѩ�w�}�s@:��k���g��M��:`�2K�+3T��V�g^�g9�=�ެn6�ץ6ꄁ=�^P�r�/b�<�s}�w6�.�zV;@]�u����ἷnѶ���2K!�}\���X�4LVJTVi�lYF���NOsu�΃+��(Բ��d�_lF\Nq�:�i��O��|�_�aإ���Sjn]�c�~S����{�X�����Mz�tf�{5�47�wK�G8\�jo��x�6w�"v9�t_֣f������O�s����g��u>�xk�����O�9o��[�ܷ��կ/8G��>kj�Xu�V�X4���s�eŮ �����K$�mJe���h�^ʀG*�<S�2��ݩ/fb�kԗ �;R߰;,�[�( �e�0��r%�4��W�$�55��e�3��3e�BNJ��!3y���T��q��rަ��;��U�cfg^��I��T�5�� �A4��=g�(�P��_
R�\�b�9%������]�q`�n���qj"i���;c����G� �����T��}����E�.��Ǔ������9�{�d\�'u�$�)��y6�d ��O:8�c��ޱ�q���="��RU�&!t��j4b�cjs����:m�H4��dQ{��O�v8܆������!{�wLS9���W�3�g#�:��U+�����Nu�C� ,����u3�.�7v�>��P���(h�����r��`�gp�;/��ɮ,-�����w�e�"f����or���͕�D�?R����8� p2���P�#�I����l��/vB
��G���'[�gN�s�"r�	��n����p��mkʟN�O���>^�G�fɣw�������}y�H�nwve�����:~���η`]~�cuq��{+���ּt�g/�h�	�ҥ�Lz��ؒ39��'˂T
��D����!8�qf�����בg���G�.��04��}DK{�ϩh����EQ�,�s����)��8f���P�ZV��+x���M�t>�ݓ�z��`��.	���tIg�>�k���H��xR�ҳ�y�������mQ� /�0����ںY��i�ޱZ�7V 0m����#�n'}�O�wS%5���ũ�n:$ɶu�
$�e#�ꭑ��E1VP�����a�+0i�j��*J
��fC0r#w^2j�)}��yRq�qV���1'Z�j���͡ 
@���%��!N;���X��r��^�N♲�rE�S������Q#G;��t��.��۸)�����M�I��>}m���5�|Zs�E�j�M?'3ss�R)�e�4Ҧ?�X&ݝ*L�z���o�ݑt����.gn{W�����Fʳ�8Ƹ��ڇ]&�kjO�-�Z�,�\
�q����gIG�whIF�^�&q�z2����8�q�%A��6��|I������n�C��bx&�L�M�yӶ.N�I+��+H���/�<��~�g�8ʵ%;<OV�z.j�����msk��2�kU �Q�H����ug:��EƊ@����7mf�`4������(Ϧ���ӱ�p�|���S�Sf)�{��p2Y}rVpk}R�g�~�-zC=�둸pWF�	8��8�E��/�I��RC�yPL(*�iƅÊ�s���f�������گ�1���c���E}��1?u:]H�3�8�q|J5��6D�'Ʉ	�d���bN�}HM�8�&ǷY6+��tC�ت�d]�%��ɨY(q���>���F-��#��o���O��d�Lz������~����`lf���n����:�v���[���Z�sOןRX6�}̹�&��6m~/;8Ƕ���W�٩�����2��S�\�y�;ޢ<'2)KK�h��ōT5�v9�_�nkuݦ�,'O�|z�|n�����b ���wK��O�;�vnW���nZ�J�#_щ�ޑ�*+����`�(qX������D�/3އp�@�Cgg9f[_�>��;�bǂp_<2��T��.�蛾߃�t,;��B5d�s����97Ս���1&��$����4��ޑ��a1VZ��ݶ=�EM�f�I���>f�=U?�jw:�d�ے)�&���4+��$f�skCjc�pou2eB�Rh)fR�]�HiBN�U��HԀ�'!�b.ǒ���)H[)�E[����ds��F8�W���Z�i�ɸC5}};	?�:�=yZ���=U�f�M�݌�s4�L[�M���L&m>9r�O%��tp���.K�봂�(y�	�LUm�t)�ߑ�t���"��TZw�w��J��oi7����N;�����s�(�:��=�|^��POF�E�Ѿ=�""�:��M-CYE��"�� D %�n�-�M }�a�i[G���J��K�
[��;q��tI&W1ƮjoM_��J:$qu2a���!�G��,�j�Y������F���P�J/0I;,��m�}��&�� #Y锝7P4& �]�Ĺȿs��8�D�=����&�����n�O�n�X�X���p��y�i"��!�Y|�1��H*NYO!�9W8�Z��MϿWU��քQ�)!3/���7��������9;��x̀e0�0,��r?��Uu;�mۙ��8�,.uݕ��E{���?�a��pd��S:�wG�����ST�9�~sx���g����4�A�d������	f��Hy��#�]&�.�s���XT�e��-�8 (�9\D��wǊ�W�H�v�dS-�#����� ��T�{�.�?/�uZ<f�kߦ6�p�uȤM�m�JGMpq�M��	�;DZy��s�$��j��?v�)�f���;��	k��\�AC�����uH�-;x���]/9��"Q#��X*��J�\�::�N�G0m���p�<�'M��h����]�o�8N�p�Ƭ�}��Ɏ¶pږ]�Ғ�#�$�oiJK�ۍ��"8D��H&i�'/dR�K��#�@O�m��Xʺ[ͤ_�g�3���g���p��Ѧfo �|��^X�H�`��ӄ@$n~I9�1K^�qH�f�������-ɂ�ǳ��j�A\<ǭa/�6c<OdS��L���;BA(ǲ��屒���Эu��E�%,[Rvټ�9B�1ށ�@���E>���ײ|���"G�8\K�eg;�W� ��jS���t��/�n��;��Q��{���*^}������Z,���e�i0*s��D�V<n�V��_^�Y�;��6}1��b���GK�@��6��2o.;���q���Kn�TFX�eۥ{[�����b�̻٘�'��]��|�X�+�6��\��!H7f�5��Pƈ�-j1p���@$��s�^Sv�N'�Ϩv�\�1Rڀ]�o��'��񁬈?�!���4��)-�����S��-,wz�-ܭ�oi�,$��c�
1+O���K����X�)e<��4��ܢ���U�r?��ł���������S���*�Ͼ��G󫞻����G�Y�%�o9�;��M@��*��OJ��i���]m��q�Ie^�&˂H	Fe4ce���:r����g��s�M��,!J��42J�q�D�@A����+*��PG���dIBq���*
��̢ė��!����Ž��ܭ���L����$��k����)���XN�4�Y����/"���ѐ�,�}Q$�"jGw�ҥ�8�>�9���	��4i��>1��I2i$�N�Zف����I��U���ݩ�/�(Vϛ~�0��2���FF��ҏ��I������ぬ����b�1ӹC�E��H	Έ-����-#`�����b�3&�-7�@�\�IRG,���Xw�F�r�)�i�b�[�20m
�OBODe��ʌ�O���h�
Uȭ����l�kN'��+^h�]	}�W���a_�xA�sWvU�<?ۛSABY>Y2�o�e5$�QZX���c�/猅l�7�3-CÂ��$z��K��a�����������������(Ғ�0/~2���j�&<b��oJ��'$��G��-����X�p�Z�"����Hui4;[��Q���P1܍��5-jf�$!Sm��~�	��L�z��0�#�����=�N�����s�Ƭ��2�&�:vDD7,��q�ӹ�8E�lX5m��n�j)P�cS��z4�[3�ek�н֜�o�t�m+K/?wu/H%⍶E�4l�-�dUEү-����3d���$;_D�]'���X�|��z��2��Tڎ��t���h�o���A#v���DܑN�{���%�BS{�a���oڤ������*
K�4ӹ��aX���"Q�TU�%ˢQj�@e�۱/���Ӥ�[������"W'�������������L�����wy�E>��"��[x��G�u��>"���@\��w����o�	y+�'
��N��Vͪ#���F A�`���.�-����DÖDBt�Eҩ[5�z��>P;n�%Xm����Z����^�L�9��T�-bh��R���r%�pT�yZR�a^�8.�%�K`����Dc��"�%Z�O<"�~��e���xT_��1����<q���ƹ��|^����@G�J=^�u�j^�$�ݮ�@��"=�Ɗ���(��[�:�i�w�<�����r��O_�9�YՐ�@,e\�1�UݮqzP�el1ܥ�%�&s�|OwD��eI�e2�6Y�$J�⚚/98;��¹E���]=�gk�ƢB����ފ��х�kzK�p:��vv4�������uU,b�ND��D^|���1�L�'rA�+���(� Gn����s�����s��U����2���3�W�p��;M�'��8��-���Q�niT��K������6[�ӓ�K�KQ��3ݦ��%�1P����'������uO��S�~S���9y���UQ>�5bk{��Å�шv'���V+M��[*i�����~�|���I��ڞ�>�~C<>|�ˌ�3
��%��3�Я����!+���n���F�o�q���,S��|�q��M�o1��dq����b��0�}BWH+mߦ����}��aC9��k*#ɤ�`���E���لa����L��>/�j�T-��j�vE��EU5�4K�4�OW�R���D�{���{:����XZ.n��#s<Ǐ������=r���}�B����!K�4��V��X�ͨ�a��;ݲ#\��uie��k'}pɤ������(+cds:9g��h�K7~[8�Ǟp�늓��޿V��{���� ���N�_^�8��e
:CRO�[Y�SI���ߗ%���r��`��;�ck{�*�E�%����G͢���N�-F۰mӮ**�py1��E=�o1���j׉�R��Ҿ�c2��J[с^��;���~;�n�5����A߿�E[qE�%�Y�7jю�R]�e���]��c�
�w���@���>J
����+]��� �*��W艸�)���}���~�`���7  �IDAT�����7:h.�>/�|�������P}��/}T�~$���;���k�����#q���M��X�x9�6#�Iis}�>�6�XLۢ�I.�J%-CH[&�^�kZX7�/p=���6�����R�ᴃݵ�zD�F$�������^��G���`o�����KM��U�;G����̱>�4:�T��9:j�d������NykS� 5�%�������W=>i��Vu����l��O�Aj��!�]�⻻:����0���e ]���x]�����N.W��]ݻ't0������6���K�{r>�װ'}L8��6�L�$���a�|-)Dd�ۼ?������C��(Y@����!��@X�%Lg���i�9��_?��w�}9F��Ǵ�����Kfj��Y���m ��3F�Ǵ�ßx����싶�?7�о����-�B��55
�s��?��G9ǝ:�br�4��,*��݆��9����kf)�a=��8i�O%�W��c���� �Q�ҸS'��>���w�^�r���~e7���ZAL7��װyc��Κ<��Ȫ��QC�ecjy<D>Ng���i���QhI�R:qu��#��{=���'��!ユ��x2}�`'�tB��U���x��+[����v�9k�B��x���s���M�\�疥��N�}ys}s,�9G���n:ḣ��{�8�_Gł+�0�c� �M����]r�$`ne���zEa[�1r�ᶓ�GU���n�X���Fo��v��0r��J���9>�|�.´�v�̣Hʊ@ NphKm�n���o?��W�dі���*�V������F��Ɓ��x��ܳ<Ւ?��E\�Ěj��9>��R]���%��ɞ�d���� �����9nY�R0��;�l�J�>q?V�f�:i��$��n�n��$yϘS���;߿Kt׺_L+/|��E�Mp�S&���N/>�Tg���G�H���6�ְy���#����HN,�Ҏ-]�A�rY�W$�i��[�=O�m@��n.�V�X���n����pm�4��l���g�E��
�>߾j��ze�dS��x�7������n�˃~p`�dͼ���v�S��[�`Q:οe]T�rj����<� 4k!����+�T>s�����g�+�B]O����+^yo������+�����;�j����Eod�,wJ��l�|��rkRS�<=��o�D+�?�0�O]�h��ʧ��|d��˳�T�.��Xx��P��Ƴ�����r��s?�@�n 1 ˂��w���E!o�}����`� h�o����! <�x91�}��cne���j��D2dˍ�6�?|R�CߞL�(
y���7�<���~�>ب����ُ��ro�ϻ}�>�g���^�'��l�Վ�E y ��������<������j�\{�3���a�8��uT�l��L��-wB��5v%��-����������M6XIۗQ�?���_�4ML�H�{���L��|��D�]�����I������5c�~vў0���]����ngD7��~����z����=�����v� >�!v�a僷�+0@�l�Xva��~��3���e��!��k
5Į�q�����n�꺴v��<s��]<�}�?L�`0���Ԯ���//,��a���OԾ$!������1P(�u�R]Z�S��š>������ �{ <����@	� k���^����?>��
�b�G%;~���@x��뮮(�W>��5�;����g��z:糭�������a��k��T��я:b����|D�9���C�Æ���_o]��������`��V��uÁ�9R)��s�O��qL�ˮ����hw&�ϛ,�յ<q�M%ٞ�f���A�N��u�%�t�s�_��ǂ�j+�s'��:2)�{su����0^�vQF��3�խ�x�է��������qÁ�[U�.��Ր� #:���6\��%�%4�.?�9>�O��-�ݾ�<����7��1���oN{�����C��ʣ�$�i��s����,Pt�L��5;������'�cN�����޷�����x�<�$U��]ق�+�қ{��7�>�2��{�  l�<AA�=�Ё�a��?+[�}���I8��q{Icv���m�+�%~!�Ck$��1�?}���NG�~�����?���~�FU�bjYi�Gumwuu$�K�^�U+�4�#��	��/Ϩ���_{����C�j0ֲY����/>��W�N�iۿ�b�q��"k�L�,����ql�:��f�2niP���}~����g|�������03�G��kN���.g��ny�LUe���8w��@�
w=�qGɪ����{.8���n���ރ��[Z����?�펹�Q�H#[W?͟(�S0�U6��%y+�ӄp���c5]n���ܟvE� ���S�7�r֨��~��NSe: ��G�wˤ'u`�(�`�pw,��j��gԖ��א�ܬ��xE�n|�|�)�|��4Ʈa�4�)���>�ތ֥�J�%�	m���MW��,� �.`�N-��L�VЙE���(mpp�n�׎Z�G��0�D�����V��������ɐFst�uc�X� ���c)��[��nհ�Md�Hs<7�(/��؝�����N�Mw��PTP!O��Rv���  8��ʔ�.pp�,�+r�ݩ.;������|�Ҋؾ��.���F���s-?�n������8�}�cQ��)���2���h��� ��ώ9oڰ����^����/[��?�r��D7l�:�����ϒf:�߾�;���{��S|��G��O�/���<�_aO`l�p��+&N-�����B-h �	�];_7ԇ�����i ���� ==��rꩾ�3�j�#�W�*3 �x�=E����x��Ҳ܏��jIrߵ�>
�@v�D��3����ӣ���O�:D4�f� �,��2� .|�ށK�Cm�}r�}�.��w2�1n���u{��za�ٯ�4�pN�(gٴ�J�6�lG��\��U�D�ړ���`0�6����`06�wCzvtMͬ�1�|K'W��2��P<?�Ϧ29�':xwe��;��!O�>��{�R���hNu1����榷3K:�讳��}F߳M�8��t�Y���`m�R�����O{�Bj�A w�΁���u�t����tRE逆tm�]eQ (,wL�){�j�_�D�J����` 0X��ܶ�=m����-SO�]'�<��tO�9x����q�۠'x��u�i���/}��R�ӿ����� �wIr (�r�aG��ޕ�4�;O�����5K!G�/��Z��`0K�?�����QKVI����d��(I�P��!�SK�pޟ�?4԰yB5Y�k=� j��-��$�CB5Y`F-�u���y��cs_%KB�Jv<������p�'o���3���?�>ԣp��E(�"y��)Ɉ�����6)*,eb    IEND�B`��  z[��MW�UW�  options.dmi �PNG
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
��M�m}{�S�N������*#�yϠ��r��XN�JHH����zĦ;q a�2;޼,,6r�� ;����7�y��+ˋ�f��+ ��'���l��~Rfh�R    IEND�B`��   ��i�MW��W�  player.dmi �PNG

   IHDR   �   `   'Tgz   'PLTE���u>-ԌR볅�٭   ������(Dl0iGf�����g�   tRNS @��f   |zTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%�����3�(17�6���$V��:@�ř�_�����nȥ����� �_��  �IDATX��X�r�6&�P]�
��tp�S鎼��#����A!�뤰;)3��\�Q#�M�Ce	?�X�g��0lv��� v�-�$_���X=}\��Ƨ�sVF�R���{9Ŕs�b��  ��^��(}?6�,��*�Q5��ie��rn����������t���� �O�?��9�� 's'S�! �� �XX�s �G 2��d­��r;u�Ms��2;^ ZR�N���`�(�,��R+��u�{��W�����/��� ������o� 7�ଦ���%e�e 螏 /�ȹmӜ�˳�*��� ����zy��)t��rP2�' ���\U�����ߨ�,@�>�@Y{k��	93���5���m�-��bc_���<�����@JL:2���1��O����+�w�@xv��������CWr!}6�K�b��!Rz1���Nل����2����@I#�A�:M�J������T����+V~F���:�yyJUEWb �r~��<(�v0g��[���hrO��~�� y�4&�7T��[�$+`>2J4�S�z�ñ�n���~x�z���&D�Q@$,���2�C���~V��4[7⤿Mq N�J^�N��Ѡ�{��q>����n���`���]�8�آH�:�@��l��;�[PEsJ���r���]ho#�-�g ���dU$��8�m�c@c8��9���6*1S��H�GzO��n���;��>���C�~��S*KK�S𧕡w%|�~��1�{�w���x�m�@�=�wh�3һl���\��ld~H�X���лl/Mosʀ�v��UM���dO]�5M))�7��"vTT���@�kpRc,?��ւft��@�\�if��.L�bIyz��f�J������c�1]�\a�}�e|��r���o�0��ޠ����!��z���õ�w ����c6?��(,�����#zpi�|��9�>�)�/@��lI9Pq��a��r�Yǣ2���ű4.뜾3����1� ���l}F#��C+sG�4���ܣ�o��X`��X`����R[`�k���p[`p����=�}�w��#��i%˱���YL���ݹ�����	�\cS`�ԕ8P\TP��o܈��Hia�Cjlg��ZV����t��J�p&�@��!%�0�Y ,�
��e���$gbM 7D��+S`�;[�`��r��0N6�`I������b��X`\�v�2�5��C�cHW�G����i(0Fb��0\�Szh�����a����mXċ�[o��w`�9�G�!��k�~޿ _�����~S��ڂ2�z��:�'����}4��6�4~tAp�����F��>= |�z���� �ͦ g��� C/-��M��������dl    IEND�B`��
  k?�MWG�W�
  Turfs.dmi �PNG

   IHDR           szz�   lzTXtDescription  x�%�;� ��=ŋ��_Kc0��@�j����݌Ƽ�n����T��Sۑz9��q ����j�As� Ґ�\=���3��X6�}9�+O�.  	�IDATX�E�ɒ�F�E����2�1�*%��L�6kk�m�H��~�V�j�eWI��p��!,}w��󮋿��;GQ���q8�L��ݻO���K\�%�2~��G���?��e�g�hH����[>�L��a�<�h�R�5��w<<<��FJ�4̈́a�8�TU�t�����oG��#�ƀR�(tX�VXk麁</�R�wC?a�E��O��뺄aH�uH)��"��۷oH)����j����ZKSwDQ�L��q�i� CP
���Z��p�|>��f�g6�R	�x��<ϜNi���n�Z����{�q`G��g�O���N'Vi���z�0�R2�#��3M�0 ���*�8f�^�$	v��B�ˁ��˺�L�@����K�u�qL۶(�� c�i�0��}�|90MK�޿�~�'C�<=eE�����O]���L�$|�����'��t�֚�jE���v;N��,�H����=��y����!I��5H)Q
�����t�Z�n�#5///E��%5Q�neY�um;��"C���q~����fCQÀ�r��8�a ��׿0Ma2�Sv����9oC��vK�����}���������8����o��Z~��W�RdYFY��i�1��\ڮ��{��N��qp=^ې��p8��y�(��Zc��x<���#�ݎ�n��0QJ1�3�X�R4M�?��;�͆4M��.�Ԏ���4M��_~�����}���8r�d��\\DC�0�Tu��y|�����/�vX�7����y���8����f�� ���׿��Z�}�'�2��R
���^��qs�<�iۖ��� ��Kh���,xxx �DQDUU$I���=�C�f�hb�&��5�ZCU��-��`�g��E)�1ж���y>�0��Q0��X|�������5�4g�i�m;�P�1��@�Y���!�1�q��Cx��������¡��7ۭҘ�kǑ�m���F���&?k��-�(�����3x��T }Q�f���<v�Z+�R�������|f�|`{��@��a0DQ@۶h��֒����+�$!/�:�X�^�P��� ��zq�뒦)��a�Y<����8P�#�cI۶H)��yi]RUƘ7�;��
%����Ç���8�K���3RJ�t��p�|>c�������4M�uM8�����>="��xG��	\Oa���g��b9T۶!���{P�Z��[W�Y�����(
)��aI�5�Ӊ��k�~)��p����z��b~�d�R��o �Z�JI���Άy�8�|�������y����ǿI!0��p8p{s�8�<><bƑ�����ˊ�ꩊ3Eޓ���D��S��}D�� BX�o����W����r:��cF�	C�����o�,8��L?th�q���;\wf����̳��Z`F)���>�������5uS��&}|�cƒ�2��#]�x�K�v4M�Ԟ��HGs�Ꭺ�����D	�BЏ�u��H�Z�u��<��P�5�`Øq0c��H�r`XaQ�-u���#q�BGQ��&ڦ!�l>* .w�MSw8���-Jk�8�(J�aDJ�R#Y��Zs�L]����!��!�2\�� ���0ay9�h��U��5�l��q	i�`F�nnCQ7\^�p\��	|�U��kR�R����~E۶dYE�H��l.h�v�x_����<?�dE�@��EѮ��O��m���&f������fI�h�dC;AY�@�u�Y(�:�2�KSw�a������8�O�m?��)ZK��4���p��{\ϣi[,�a0���4Y�hE���҉G/�ʌ�4�q���!�q\�E��l9�{������y��<�TU�R���=q�I�q(���PJ1K�|?`ʲ�,K\\�e�,����Aж�0  �lw��󌛛=����bǞ<ϩ��߿SU}?�%���}߳�lhہa��_�2���p{{���#�����3i�rqqA�u!P����m[v��?g���Zr}�����5jK��b�'��i٬ߡ�EZ��ڶyKA�+�,��{��FJނl��f�8ȳ�y2h	�8��|d�)f�2g:./V���t fpEF�yI]��q�֚��H��H))��$	h�e,�a���6����.�
�1��+��<����~�HS.��)��)i��s4M����7L��8�_��a�]qww�n����4`���y�}��8��۾C"�ʜ�m�m7HI3�03�#EQxQ�9OO/`��E��(
1�0Mi����m�7�qDY�t]��3x�d���WW.���ډǇ�Lӄ�9A X��Z�F� $�A����1o�$!EQ,����Um�R�-�W����:׏$a�l&|ǥ*
��yG���o����*�hG�>�pyy�1���{ff<�Aș��K��'N�ʄ�OUU���3�=e�恈�X
�>�1���~ރ���G�0rް_ķ3z�x���ˑ����*a�l��
ǌ��������̘W�R1���~�� ���&2n:    IEND�B`��   0��MWnyW�   Inv.dmi �PNG

   IHDR           I��   PLTE   �z=�   tRNS @��f   IzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J eW?� ��mK}�;   IDAT�c`�   � �O�    IEND�B`��   o볦�`W_W�  dropboxes.dms <byondclass name="dropboxes">

<!-- Our CSS styling goes here -->

<style>
	#dropboxes {

	}
	.dropbox {
		position: absolute;
		width: 32px;
		height: 32px;
		display: block;
		outline: 2px dashed #ced3e7;
		top: 100px;
		left: 100px;
		opacity: 0.6;
	}
</style>

<!-- Our JavaScript code goes here -->
<script>
(function(){
	var dragSrc;
	function allowDrop(e) {
		e.preventDefault();
		return false;
	};
	function drop(e) {
		e.stopPropagation();

		this.innerHTML = e.dataTransfer.getData('text/html');
		var inside = document.getElementById(e.target.getAttribute("id")).firstChild;
		console.log(inside);

		// get vars of all the locations and slots
		var dragged_inv_ref = inside.getAttribute("data-ref");
		var drop_direction = e.target.getAttribute("data-dir");
		console.log("drop dir:"+drop_direction+"---ref:"+dragged_inv_ref+"--- innerHTML:"+this.innerHTML);
		// send command to byond client to change the inv_positions in user's inventory
		byond.fn.topic('action=dropitem;v1='+dragged_inv_ref+";v2="+drop_direction);

		var dropboxes = document.getElementById('dropboxes');
		dropboxes.innerHTML = '';

		return false;
	};
	return {
		fn: {

    output: function(obj,sub) {
      this.elem.innerHTML = obj.null ? '' : obj.text;


		// decode and fix up the json_encode'd list from the output
		var string = byond.htmlDecode(obj.text);
		var id, m, icon='';
		string = string.replace(/\n+$/,'');
		string = string.replace(/^\n+/,'');
		string = string.replace(/<br\s*\/?>/gi,'');

		//console.log(string);
		// make a new array that will parse the fixed up string from above
		var inv_array = JSON.parse(string);

		for(var key in inv_array) {
			if(string.hasOwnProperty(key)) {
			// find the first key and parse it too, so that we can dig into the items actual data

				item = inv_array[key];
				id = item.ref;
				//console.log("ref"+item.ref+"-loc:"+item.usrlocx+","+item.usrlocy+","+item.usrlocz+"-slot:"+item.slot);
				console.log(item.checkNorth);
				if(item.checkNorth == 1) {
					this.elem.innerHTML = "<div id=dropboxNorth data-dir=north class=dropbox></div>";
				}
				this.elem.innerHTML += "<div id=dropboxWest data-dir=west class=dropbox></div>";
				this.elem.innerHTML += "<div id=dropboxEast data-dir=east class=dropbox></div>";
				this.elem.innerHTML += "<div id=dropboxSouth data-dir=south class=dropbox></div>";
				var map = document.getElementById('map');
				map.style.width = window.innerWidth+'px';
				map.style.height = window.innerHeight+'px';
				console.log("map width:"+map.style.width + " window width:" + window.innerWidth + "window height:" + window.innerHeight)
				var midx = window.innerWidth/2
				var midy = window.innerHeight/2

				var dropboxNorth = document.getElementById('dropboxNorth');
				dropboxNorth.addEventListener('dragover', allowDrop);
				dropboxNorth.addEventListener('drop', drop);
				dropboxNorth.style.top = parseInt(midy-66)+'px';
				dropboxNorth.style.left = parseInt(midx)+'px';
				var dropboxWest = document.getElementById('dropboxWest');
				dropboxWest.addEventListener('dragover', allowDrop);
				dropboxWest.addEventListener('drop', drop);
				dropboxWest.style.top = parseInt(midy-34)+'px';
				dropboxWest.style.left = parseInt(midx-34)+'px';
				var dropboxEast = document.getElementById('dropboxEast');
				dropboxEast.addEventListener('dragover', allowDrop);
				dropboxEast.addEventListener('drop', drop);
				dropboxEast.style.top = parseInt(midy-34)+'px';
				dropboxEast.style.left = parseInt(midx+34)+'px';
				var dropboxSouth = document.getElementById('dropboxSouth');
				dropboxSouth.addEventListener('dragover', allowDrop);
				dropboxSouth.addEventListener('drop', drop);
				dropboxSouth.style.top = parseInt(midy+2)+'px';
				dropboxSouth.style.left = parseInt(midx)+'px';

			}
		}
    }
  }
    };
})()
</script>

<div id="content" class="content"></div>    <!-- The div that will be containing our text. -->
</byondclass>