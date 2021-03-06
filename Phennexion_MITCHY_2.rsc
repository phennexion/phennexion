�    Kg�7yW�xW�  dropboxs.dms <byondclass name="dropboxs">

<!-- Our CSS styling goes here -->

<style>
	#drop {
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
</style>

<!-- Our JavaScript code goes here -->

<script>
{
  config: {bananas: 3},
  fn: {
    output: function(obj,sub) {
      this.elem.innerHTML = obj.null ? '' : obj.text;
    }
  }
}
</script>
<div id="content" class="content"></div>    <!-- The div that will be containing our text. -->
</byondclass>�   �Y��5yW�vW�  first_byondclass.dms <byondclass name="firstclass">

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

</byondclass>�   �|�&�yW�yW�  dropboxs.dms <byondclass name="dropboxes">

<!-- Our CSS styling goes here -->

<style>
	#dropboxes {
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
</style>

<!-- Our JavaScript code goes here -->

<script>
{
  fn: {
    output: function(obj,sub) {
      this.elem.innerHTML = obj.null ? '' : obj.text;
      console.log("got it");
    }
  }
}
</script>
<div id="content" class="content"></div>    <!-- The div that will be containing our text. -->
</byondclass> text. -->
</byondclass>�   y', sans-serif;
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
	O return "clearinv"�&   ��}�5yW:rWx&  Inventory.dms <byondclass name="bags">

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
			document.getElementById('inv_toggle').style.backgroundImage = "url('inv_expand.png')";
		}
		else
		{
			document.getElementById('inv_toggle').style.backgroundImage = "url('inv_collapse.png')";
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


</byondclass>�Y  A,�5yW�W�Y  slotbg.png �PNG
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
+,=������(*6&������������  ���S(k!l�d    IEND�B`��  <�7�5yW_�W�  inv_header.png �PNG
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

���������   ��r`߆͟�    IEND�B`�R  �<�	5yWJ�W�Q  inv_collapse.png �PNG
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
  �� �� �  �� �  �  �� �  �  	 ����� ����       �����  �       	�� �   ��   ���X�8-њ�    IEND�B`�]� �"wM5yW5RWA� inv_bg.png �PNG
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
������      ���      ���  ��D���F��    IEND�B`�DQ  �"�5yWϚW$Q  inv_expand.png �PNG
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
  �� �� �  �� �  �  �� �  �  	 ����� ����       �����  �       	�� �   ��   ��%e�3`z�K    IEND�B`��  �LN5yWΖW�  minerals.dmi �PNG
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
���,��*-�Мn�&�Ap_kv�k���J�,[D��X�{|||��NwW�Gc����k̚4NF����=`�?���T��t{�@����gN���M�����K��$    IEND�B`��  z[�5yW�UW�  options.dmi �PNG
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
��M�m}{�S�N������*#�yϠ��r��XN�JHH����zĦ;q a�2;޼,,6r�� ;����7�y��+ˋ�f��+ ��'���l��~Rfh�R    IEND�B`�)  ,��5yW.$W  player.dmi �PNG

   IHDR           I��   PLTE���  3���   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   EIDAT�c`��? 	�?@�����$��o``��� n���l �(F�������F0 
 % �G#��ĳ�    IEND�B`��
  k?5yWj=W�
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
ǌ��������̘W�R1���~�� ���&2n:    IEND�B`��   0�5yWnyW�   Inv.dmi �PNG

   IHDR           I��   PLTE   �z=�   tRNS @��f   IzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J eW?� ��mK}�;   IDAT�c`�   � �O�    IEND�B`��    d��OryWryW�  dropboxs.dms <byondclass name="dropboxes">

<!-- Our CSS styling goes here -->

<style>
	#dropboxes {
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
</style>

<!-- Our JavaScript code goes here -->

<script>
{
  config: {bananas: 3},
  fn: {
    output: function(obj,sub) {
      this.elem.innerHTML = obj.null ? '' : obj.text;
    }
  }
}
</script>
<div id="content" class="content"></div>    <!-- The div that will be containing our text. -->
</byondclass>�   �F�ryWeyW�  index.dms <html>
<head>
<link href='https://fonts.googleapis.com/css?family=Play' rel='stylesheet' type='text/css'>
</head>
<body>
	<div id="main" byondclass="child" skinparams="left=map;is-vert=true;width=0;zoom=0;">
		<div id="map" byondclass="map"></div>
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
	O return "clearinv"_   ����T�WS�W@  dropboxes.dms <byondclass name="dropboxes">

<!-- Our CSS styling goes here -->

<style>
	#dropboxes {

	}
	.dropbox {
		position: absolute;
		width: 32px;
		height: 32px;
		display: block;
		outline: 2px solid white;
		top: 100px;
		left: 100px;
	}
</style>

<!-- Our JavaScript code goes here -->

<script>
{
  fn: {
    output: function(obj,sub) {
      this.elem.innerHTML = obj.null ? '' : obj.text;


		// decode and fix up the json_encode'd list from the output
		var string = byond.htmlDecode(obj.text);
		var id, m, icon='';
		string = string.replace(/\n+$/,'');
		string = string.replace(/^\n+/,'');
		string = string.replace(/<br\s*\/?>/gi,'');

		console.log(string);
		// make a new array that will parse the fixed up string from above
		var inv_array = JSON.parse(string);

		for(var key in inv_array) {
			if(string.hasOwnProperty(key)) {
			// find the first key and parse it too, so that we can dig into the items actual data

				item = inv_array[key];
				id = item.ref;
				console.log("ref"+item.ref+"-loc:"+item.usrlocx+","+item.usrlocy+","+item.usrlocz+"-slot:"+item.slot);
				this.elem.innerHTML = "<div id=dropbox1 class=dropbox></div>";
				}
		}
    }
  }
}
</script>
<div id="content" class="content"></div>    <!-- The div that will be containing our text. -->
</byondclass>