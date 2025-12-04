/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

//CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
//};

CKEDITOR.editorConfig = function( config ) {
	config.height = '250px';
	config.font_names='굴림/Gulim;돋움/Dotum;바탕/Batang;궁서/Gungsuh;Arial/Arial;토마토/Tahoma;Verdana/Verdana';
	config.language='ko';
	config.uiColor = '#e7ecf1';
	config.toolbarGroups = [
		{ name:  'document', groups:  [ 'mode', 'document', 'doctools' ] },
		{ name:  'clipboard', groups:  [ 'clipboard', 'undo' ] },
		{ name:  'editing', groups:  [ 'find', 'selection', 'spellchecker', 'editing' ] },
		{ name:  'forms', groups:  [ 'forms' ] },
		{ name:  'basicstyles', groups:  [ 'basicstyles', 'cleanup' ] },
		{ name:  'paragraph', groups:  [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
		{ name:  'links', groups:  [ 'links' ] },
		{ name:  'insert', groups:  [ 'insert' ] },
		{ name:  'styles', groups:  [ 'styles' ] },
		{ name:  'colors', groups:  [ 'colors' ] },
		{ name:  'tools', groups:  [ 'tools' ] },
		{ name:  'others', groups:  [ 'others' ] },
		{ name:  'about', groups:  [ 'about' ] }
	];

	config.removeButtons = 'Save,Preview,NewPage,Print,Templates,Cut,Copy,Paste,PasteText,PasteFromWord,Undo,Redo,Find,Replace,SelectAll,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,RemoveFormat,Blockquote,CreateDiv,BidiLtr,BidiRtl,Language,Anchor,Flash,PageBreak,Iframe,Styles,Format,Maximize,ShowBlocks,About';
};

CKEDITOR.on('dialogDefinition', function (ev) {
            var dialogName = ev.data.name;
            var dialog = ev.data.definition.dialog;
            var dialogDefinition = ev.data.definition;
            if (dialogName == 'image') {
                dialog.on('show', function (obj) {
                    this.selectPage('Upload'); //업로드텝으로 시작
                });
                dialogDefinition.removeContents('advanced'); // 자세히탭 제거
                dialogDefinition.removeContents('Link'); // 링크탭 제거
            }
        });
