
//자료 기본사항
const search_item_base = async (reg_state) => {
	let formData = new FormData(document.getElementById('add-form'));
	
	const form = await fetch('/searchItemBase.do', {
    		method:'POST',
    		headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: new URLSearchParams(formData)
    	})

		const { itemBaseList } = await form.json();
    	itemBaseList.length ? set_itemBase_input(itemBaseList) : alert('검색하신 데이터가 없습니다.');
}

//자료기본사항 아래 항목들
const set_itemBase_input = async (list) => {
	//$('#add-form')[0].reset();
	sessionStorage.setItem("item_idx", list[0].item_idx);
	$('input[name=item_nm]').val(list[0].item_nm);
	$('input[name=item_se_nm]').val(list[0].item_se_nm);
	$('input[name=item_eng_nm]').val(list[0].item_eng_nm);
	$('input[name=author]').val(list[0].author);
	$('input[name=qty]').val(list[0].qty);
	$('select[name=qty_unit_code_idx]').val(list[0].qty_unit_code_idx).prop("selected", true);
	$('select[name=icao_code_idx]').val(list[0].icao_code_idx).prop("selected", true);
	$('select[name=existence_code_idx]').val(list[0].existence_code_idx).prop("selected", true);
	$('input[name=management_no]').val(list[0].management_no);
	$('select[name=preservation_need]').val(list[0].preservation_need).prop("selected", true);
	$('#feature').val(list[0].feature);
	$('#condition_code_idx').val(list[0].condition_code_idx).prop("selected", true);
	$('#ranking_code_idx').val(list[0].ranking_code_idx).prop("selected", true);
	$('#remark').val(list[0].remark);
	//$('input[name=management_no]').val(list[0].management_no); //보존처리자
	
	const form = await fetch('/searchItemBaseChild.do?item_idx=' + list[0].item_idx);
	const { taxonomyList, countryList, materialList, measurementList, obtainmentList, involvementList,
				InsuranceList, copyrightList, publicServiceList, keywordList } = await form.json();
				
	taxonomyList.forEach(async (e, i) => {
		$('#class-tbody').children('tr:not(:first-child)').remove();
		i != 0 ? addClassTd('class-table', 'class-tbody') : '';
		$('#class1_code_idx'+i).val(e.class1_code_idx).prop("selected", true);
		$('#class2_code_idx'+i).val(e.class2_code_idx).prop("selected", true);
		$('#class3_code_idx'+i).val(e.class3_code_idx).prop("selected", true);
	})
	
	countryList.forEach(async (e, i) => {
		$('#country-tbody').children('tr:not(:first-child)').remove();
		$('#country-select'+i).val(e.country_code_idx).prop("selected", true);
		await changeCountry(e.country_code_idx, 0);
		$('#era-select'+i).val(e.era_code_idx).prop("selected", true);
		$('#detail_year'+i).val(e.detail_year);
	})
	
	materialList.forEach(async (e, i) => {
		$('#material-tbody').children('tr:not(:first-child)').remove();
		if(i != 0) addClassTd('material-table', 'material-tbody');
		$('#material1_code_idx'+i).val(e.material1_code_idx).prop("selected", true);
		await changeMaterial(e.material1_code_idx, i);
		$('#material2_code_idx'+i).val(e.material2_code_idx).prop("selected", true);
		$('#material_detail'+i).val(e.material_detail);
	})
	
	measurementList.forEach((e, i) => {
		$('#measurement-tbody').children('tr:not(:first-child)').remove();
		if(i != 0) addClassTd('measurement-table', 'measurement-tbody');
		$('#measurement_item_type'+i).val(e.item_type);
		$('#measurement_code_idx'+i).val(e.measurement_code_idx).prop("selected", true);
		$('#measurement_value'+i).val(e.measurement_value);
		$('#measurement_unit_code_idx'+i).val(e.measurement_unit_code_idx).prop("selected", true);
	})
	
	obtainmentList.forEach((e, i) => {
		$('#obt_obtainment_date').val(e.obtainment_date);
		$('#obt_obtainment_code_idx').val(e.obtainment_code_idx).prop("selected", true);
		$('#obt_purchase1_code_idx').val(e.purchase1_code_idx).prop("selected", true);
		$('#obt_purchase2_code_idx').val(e.purchase2_code_idx).prop("selected", true);
		$('#obt_obtainment_price').val(e.obtainment_price);
		$('#obt_price_unit_code_idx').val(e.price_unit_code_idx).prop("selected", true);
		$('#obt_won_exchange').val(e.won_exchange);
		$('#obt_obtainment_no').val(e.obtainment_no);
		$('#obt_obtainment_place').val(e.obtainment_place);
		$('#obt_obtainment_addr').val(e.obtainment_addr);
		$('#obt_obtainment_detail').val(e.obtainment_detail);
		$('#obt_record_date').val(e.record_date);
		$('#obt_designation').val(e.designation);
		$('#obt_redemption').val(e.redemption);
		$('#obt_country_code_idx').val(e.country_code_idx).prop("selected", true);
		$('#obt_qty').val(e.qty);
		$('#obt_qty_unit_code_idx').val(e.qty_unit_code_idx).prop("selected", true);
		$('#obt_redemption_date').val(e.redemption_date);
	})
	
	involvementList.forEach((e,i) => {
		$('#possession-tbody').children('tr:not(:first-child)').remove();
		if(i != 0) addClassTd('possession-table', 'possession-tbody');
		$('#invol_possession_code_idx').val(e.possession_code_idx).prop("selected", true);
		$('#invol_item_no').val(e.item_no);
		$('#invol_remark').val(e.remark);
	})
	
	InsuranceList.forEach((e,i) => {
		$('#insurance-tbody').children('tr:not(:first-child)').remove();
		if(i != 0) addClassTd('insurance-table', 'insurance-tbody');
		$('#insu_agreed_value').val(e.agreed_value);
		$('#insu_price_unit_code_idx').val(e.price_unit_code_idx).prop("selected", true);
		$('#insu_start_date').val(e.start_date);
		$('#insu_end_date').val(e.end_date);
		$('#insu_rental_org').val(e.rental_org);
		$('#insu_remark').val(e.remark);
	})
	
	copyrightList.forEach((e,i) => {
		$('#copyright-tbody').children('tr:not(:first-child)').remove();
		if(i != 0) addClassTd('copyright-table', 'copyright-tbody');
		$('#copy_copyright').val(e.copyright).prop("selected", true);
		$('#copy_owner').val(e.owner);
		$('#copy_expiry_date').val(e.expiry_date);
		$('#copy_usage_permission').val(e.usage_permission);
		$('#copy_copyright_transfer').val(e.copyright_transfer);
		$('#copy_remark').val(e.remark);
	})
	
	publicServiceList.forEach((e,i) => {
		$('#public_service').val(e.public_service).prop("selected", true);
		$('#reason').val(e.reason);
		$('#ggnuri_code_idx').val(e.ggnuri_code_idx).prop("selected", true);
	})
	
	keywordList.forEach((e,i) => {
		$('#keyword').val(e.keyword);
	})
	
	await getMovementList();
	await getSpeciality();
	await getImageList();
	const form2 = await fetch('/getPreservation.do?item_idx=' + list[0].item_idx);
	const { preservationList } = await form2.json();
	preservationList.forEach((e, num) => {
		num!=0 ? cloneDiv() : '';
		$('#settings').children('option:not(:first)').remove();
		$('#treatment_org'+num).val(e.treatment_org);
		$('#processor'+num).val(e.processor);
		$('#start_date'+num).val(e.start_date);
		$('#end_date'+num).val(e.end_date);
		$('#content'+num).val(e.content);
		$('#remark'+num).val(e.remark);
		
		$('#before-img-preview').children().remove();
		$('#after-img-preview'+num).children().remove();
		let beforeImg = e.image.filter(r => r.image_state == 'B');
		let afterImg = e.image.filter(r => r.image_state == 'A');
		$('#result-img-preview'+num).append('<div style="width:200px; height:250px; margin: 5px 5px 5px 5px; display:inline-block;"><img id="result-img'+num+'" style="width: 200px; height: 200px;"/><p style="text-align:center;">'+e.image_nm+'</p></div>');
		document.getElementById('result-img'+num).src = e.file_path+e.file_nm;
		
		beforeImg.forEach((r, i) => {
			$('#before-img-preview'+num).append(
							'<div id="before'+num+'Div'+i+'" style="width:200px; height:250px; margin: 10px 10px 10px 10px; display:inline-block;">'+
							'<input type="checkbox" value="'+i+'" id="before'+num+'checkbox'+i+'" name="before'+num+'checkbox" class="before'+num+'checkbox" style="position: relative; top: 20px; z-index: 1; width:15px; height:15px;"/>' +
						    '<label for="before'+num+'checkbox'+i+'">' +
						    '<img id="before'+num+'img'+i+'" style="width: 200px; height: 200px;"/></label>'+
						    '<p style="text-align:center; text-overflow: ellipsis; white-space : nowrap; overflow : hidden;">'+r.image_nm+'</p></div>');
					document.getElementById('before'+num+'img'+i).src = r.image_path+r.image_nm;
		})
		
		afterImg.forEach((r, i) => {
			$('#after-img-preview'+num).append(
					'<div id="after'+num+'Div'+i+'" style="width:200px; height:250px; margin: 10px 10px 10px 10px; display:inline-block;">' +
					'<input type="checkbox" value="'+i+'" id="after'+num+'checkbox'+i+'" name="after'+num+'checkbox" class="after'+num+'checkbox" style="position: relative; top: 20px; z-index: 1; width:15px; height:15px;"/>' +
					'<label for="after'+num+'checkbox'+i+'">' +
					'<img id="after'+num+'img'+i+'" style="width: 200px; height: 200px;"/></label>' +
					'<p style="text-align:center; text-overflow: ellipsis; white-space : nowrap; overflow : hidden;">'+r.image_nm+'</p></div>');
					
					document.getElementById('after'+num+'img'+i).src = r.image_path+r.image_nm;
		})
		
		//처리결과, 보존처리후, 보존처리전 preview랑 값 추가해야함
		
		
	})
	
	let item_idx = sessionStorage.getItem("item_idx");
	
	$.ajax({
			type : 'POST',                 
			url : '/getKeywordList.do',
			data: {
				item_idx: item_idx
			},			
			dataType : "html",           
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function() {
					alert('통신실패!');
			},
			success : function(data) {  
				$('#keywordZone').empty().append(data);
			}
		});
	
}


function metaDataListView(value1,value2,value3,value4,value5){
		$('#possession_code_idx').val(value1);
		$('#org_code_idx').val(value2);
		$('#item_no').val(value3);
		$('#item_detail_no').val(value4);
		//$('#reg_state').val(value5);
		var pop_title = "popupOpener" ;
		
		window.open("", pop_title, 'width=1000, height=1000') ;
		
		var frmData = document.metaDataListViewForm ;
		frmData.target = pop_title ;
		frmData.action = "/metaDataListView.do" ;
		
		frmData.submit() ;
}

