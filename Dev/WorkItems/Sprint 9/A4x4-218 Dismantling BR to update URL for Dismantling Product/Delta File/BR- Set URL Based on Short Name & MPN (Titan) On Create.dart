~BR : brSetURLBasedonShortnameMpnTitanDescription : BR- Set URL Based on Short Name & MPN (Titan) On Create~
varUrl:=GetAttributeValue["_DEFAULT","_DEFAULT","thgurl"];
varApprovedShortName:=GetAttributeValue["_DEFAULT","_DEFAULT","thgapproveshortname"];
varMpn:=GetAttributeValue["_DEFAULT","_DEFAULT","thgmpntitan"];
varShortName:=GetAttributeValue["_DEFAULT","_DEFAULT","thgshortname"];
varDisclaimer:=GetAttributeValues["_DEFAULT","_DEFAULT","thgdisclaimers"];
varPartial:=GetAttributeValue["_DEFAULT","_DEFAULT","thgpartial"];
varHideMpnSku:=GetAttributeValue["_DEFAULT","_DEFAULT","thgshowmpnsku"];
varNgSku:=GetAttributeValues["_DEFAULT","_DEFAULT","thgngsku"];
varShortNameContainsMpn:="false";
varAll4by4Url:="https://www.allfourx4.com.au/";
varFinalUrlConcatValue:="";
varModifyUrl:="false";
varDismantlingProduct := GetAttributeValues["_DEFAULT","_DEFAULT","thgdismantlingproduct"];
varDismantlingShortName:=GetAttributeValue["_DEFAULT","_DEFAULT","thgshortnamedismantlingvehicle"];
varModifyValue:="";
varDismantling:=false;

IIF[IsNullOrEmpty[varUrl] AND varApprovedShortName="true" AND varDismantlingProduct<>true AND IsNullOrEmpty[varShortName]=false,
SetVariable["varModifyUrl","true"] AND SetVariable["varModifyValue",varShortName],false] AND

IIF[IsNullOrEmpty[varUrl] AND IsNullOrEmpty[varDismantlingProduct]=false AND IsNullOrEmpty[varDismantlingShortName]=false AND 
varDismantlingProduct=true, 
SetVariable["varModifyUrl","true"] AND SetVariable["varModifyValue",varDismantlingShortName] AND 
SetVariable["varDismantling",true],false] AND

IIF[varModifyUrl="true",
SetVariable["varModifyValue",Trim[varModifyValue]] AND 
SetVariable["varModifyValue",Replace[varModifyValue," ","-"]] AND 
SetVariable["varModifyValue",Replace[varModifyValue,".",""]] AND 
SetVariable["varModifyValue",Replace[varModifyValue,",",""]] AND 
SetVariable["varModifyValue",Replace[varModifyValue," - ","-"]] AND 
SetVariable["varModifyValue",Replace[varModifyValue,"&",""]] AND 
SetVariable["varModifyValue",Replace[varModifyValue,"&-",""]] AND 
SetVariable["varModifyValue",Replace[varModifyValue,"-&",""]] AND 
SetVariable["varModifyValue",Replace[varModifyValue,"--","-"]] AND
SetVariable["varModifyValue",Replace[varModifyValue,"**",""]] AND
SetVariable["varModifyValue",Replace[varModifyValue,"*",""]] AND
SetVariable["varModifyValue",Replace[varModifyValue,"/","-"]] AND 
SetVariable["varModifyValue",Remove[varModifyValue,"/"]] AND 
SetVariable["varModifyValue",FindAndReplaceByRegex[varModifyValue,"[\\]",""]] AND 
SetVariable["varModifyValue",Trim[varModifyValue]],false] AND

IIF[varModifyUrl="true" AND varDismantling=true,
SetVariable["varFinalUrlConcatValue",Replace[varModifyValue,"--","-"]] AND
SetAttributeValue["_DEFAULT","_DEFAULT","vardummyFinalUrlConcatValue",varFinalUrlConcatValue],false] AND  

IIF[varModifyUrl="true" AND varDismantling=false AND (IsNullOrEmpty[varHideMpnSku] OR varHideMpnSku="false") AND Contains[varMpn,varModifyValue]=false AND Contains[Remove[varMpn,"-"],varModifyValue]=false,
SetVariable["varFinalUrlConcatValue",Concat[varModifyValue,"-",Trim[varMpn]]] AND
SetVariable["varFinalUrlConcatValue",Replace[varFinalUrlConcatValue,"--","-"]],false] AND

IIF[varModifyUrl="true" AND varDismantling=false AND (IsNullOrEmpty[varHideMpnSku] OR varHideMpnSku = "false") AND Contains[varMpn,varModifyValue],
SetVariable["varFinalUrlConcatValue",Trim[varModifyValue]] AND
SetVariable["varFinalUrlConcatValue",Replace[varFinalUrlConcatValue,"--","-"]] ,false] AND

IIF[varModifyUrl="true" AND varHideMpnSku = "true" AND varDismantling=false,
SetVariable["varModifyValue",FindAndReplaceByRegex[varModifyValue,varMpn,""]] AND
SetVariable["varModifyValue",FindAndReplaceByRegex[varModifyValue,Remove[varMpn,"-"],""]] AND
SetVariable["varFinalUrlConcatValue",Concat[varModifyValue,"-",Trim[varNgSku]]] AND
SetVariable["varFinalUrlConcatValue",Replace[varFinalUrlConcatValue,"--","-"]],false] AND

IIF[varModifyUrl="true",
SetVariable["varFinalUrlConcatValue",Replace[varFinalUrlConcatValue,"--","-"]] AND
SetVariable["varFinalUrlConcatValue",Trim[varFinalUrlConcatValue]] AND
SetAttributeValue["_DEFAULT","_DEFAULT","thgurl",Concat[varAll4by4Url,varFinalUrlConcatValue]] AND
SetAttributeValue["_DEFAULT","_DEFAULT","thgurlbc",Concat["/",varFinalUrlConcatValue,"/"]] ,false] AND

IIF[HaveAnyAttributesChanged["_DEFAULT","_DEFAULT","thgurl"]=true AND IsNullOrEmpty[varUrl]=false AND varModifyUrl="false",
SetVariable["varModifiedUrlBc",Concat[Replace[varUrl,varAll4by4Url,"/"],"/"]] AND
SetAttributeValue["_DEFAULT","_DEFAULT","thgurlbc",varModifiedUrlBc],false]