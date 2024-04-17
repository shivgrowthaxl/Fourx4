varbrandtitan:="";
varproducttype:="";
varmpntitan:="";
varcrossref:="";
varsupersedespart:="";
varsynonym:="";
varskutitan:="";
varkeywordisempty:="";
vartempkeyword:="";
varlastptypechar:="";
varisproducttypeplural:="";
varentityId:="";
varsingular:="";
varplural:="";
variterateitems:="";
varfinalkeyword:="";
varDismantlingVehicle:=GetAttributeValue["_DEFAULT","_DEFAULT","thgdismantlingproduct"];
varFinalKeywordDismantling:="Dismantling Vehicle";

IIF[HaveAnyAttributesChanged["_DEFAULT","_DEFAULT","thgdismantlingproduct","thgkeywords"] AND 
IsNullOrEmpty[GetAttributeValue["_DEFAULT","_DEFAULT","thgkeywords"]] AND varDismantlingVehicle=true,
SetAttributeValue["_DEFAULT","_DEFAULT","thgkeywords",varFinalKeywordDismantling],false]
AND

IIF[HaveAnyAttributesChanged["_DEFAULT","_DEFAULT","thgbrandtitan","thgproducttype","thgmpntitan","thgcrossrefnos","thgsupersedespartnos","thgkeywords","thgsynonym","thgskutitan","thgdismantlingproduct"] AND IsNullOrEmpty[GetAttributeValue["_DEFAULT","_DEFAULT","thgkeywords"]]
AND varDismantlingVehicle<>true,
 
 SetVariable["varbrandtitan",GetAttributeValue["_DEFAULT","_DEFAULT","thgbrandtitan"]] AND
 SetVariable["varproducttype",GetAttributeValue["_DEFAULT","_DEFAULT","thgproducttype"]] AND
 SetVariable["varmpntitan",GetAttributeValue["_DEFAULT","_DEFAULT","thgmpntitan"]] AND
 SetVariable["varcrossref",GetAttributeValues["_DEFAULT","_DEFAULT","thgcrossrefnos"]] AND
 SetVariable["varsupersedespart",GetAttributeValues["_DEFAULT","_DEFAULT","thgsupersedespartnos"]] AND
 SetVariable["varsynonym",GetAttributeValue["_DEFAULT","_DEFAULT","thgsynonym"]] AND
 SetVariable["varskutitan",GetAttributeValue["_DEFAULT","_DEFAULT","thgskutitan"]] AND
 SetVariable["varkeywordisempty","true"]
 ,false] AND

~IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varDismantlingVehicle]=false AND varDismantlingVehicle=true,
SetAttributeValue["_DEFAULT","_DEFAULT","thgkeywords",varFinalKeywordDismantling]
,false] AND~

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varproducttype] = false,
SetVariable["varlastptypechar",Substring[varproducttype,Len[varproducttype]-1,1]]
,false] AND 

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varproducttype] = false AND varlastptypechar = "s",
SetVariable["varisproducttypeplural","true"] AND SetVariable["varplural",varproducttype]
,SetVariable["varisproducttypeplural","false"] AND SetVariable["varsingular",varproducttype]] AND 

IIF[varkeywordisempty = "true" AND varisproducttypeplural = "false",
SetVariable["varentityId",GetEntityId["ANDACROSS","refexceptionalproducttype","self:self",Concat["Singular:_DEFAULT:_DEFAULT:exact:",varproducttype]]] AND 
SetVariable["varplural",GetEntityAttributeValueById["_DEFAULT","_DEFAULT",varEntityId,"refexceptionalproducttype","Plural"]]
,false] AND 

IIF[varkeywordisempty = "true" AND varisproducttypeplural = "false" AND IsNullOrEmpty[varplural],
SetVariable["varplural",Concat[varproducttype,"s"]]
,false] AND 

IIF[varkeywordisempty = "true" AND varisproducttypeplural = "true",
SetVariable["varentityId",GetEntityId["ANDACROSS","refexceptionalproducttype","self:self",Concat["Plural:_DEFAULT:_DEFAULT:exact:",varproducttype]]] AND 
SetVariable["varsingular",GetEntityAttributeValueById["_DEFAULT","_DEFAULT",varEntityId,"refexceptionalproducttype","Singular"]] AND 
SetAttributeValue["_DEFAULT","_DEFAULT","dummyvarsingular1",varsingular]
,false] AND 

IIF[varkeywordisempty = "true" AND varisproducttypeplural = "true" AND IsNullOrEmpty[varsingular]
,SetVariable["varsingular",Left[varproducttype,Len[varproducttype] - "1"]]
,false] AND 

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varbrandtitan] = false,
SetVariable["vartempkeyword",Concat[varbrandtitan,", "]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varproducttype] = false,
SetVariable["vartempkeyword",Concat[vartempkeyword,varsingular,", "]] AND
SetVariable["vartempkeyword",Concat[vartempkeyword,varplural,", "]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varsynonym] = false,
SetVariable["vartempkeyword",Concat[vartempkeyword,varsynonym,", "]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varmpntitan] = false,
SetVariable["vartempkeyword",Concat[vartempkeyword,Remove[varmpntitan,"-"],", "]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varmpntitan] = false AND Contains["-",varmpntitan],
SetVariable["vartempkeyword",Concat[vartempkeyword,varmpntitan,", "]]
,false] AND
 
IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varskutitan] = false AND varmpntitan<>varskutitan AND Contains["-",varskutitan],
SetVariable["vartempkeyword",Concat[vartempkeyword,varskutitan,", "]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varskutitan] = false AND varmpntitan<>varskutitan,
SetVariable["vartempkeyword",Concat[vartempkeyword,Remove[varskutitan,"-"],", "]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varcrossref] = false,
SetVariable["vartempkeyword",Concat[vartempkeyword,Replace[varcrossref,"||",", "],", "]]
,false] AND
 
IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varsupersedespart] = false,
SetVariable["vartempkeyword",Concat[vartempkeyword,Replace[varsupersedespart,"||",", "]]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[vartempkeyword] = false,
SetVariable["vartempkeyword",Trim[vartempkeyword]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[varsupersedespart],
SetVariable["vartempkeyword",Substring[vartempkeyword,0,Len[vartempkeyword]-1]]
,false] AND

IIF[varkeywordisempty = "true" AND IsNullOrEmpty[vartempkeyword] = false,
SetVariable["variterateitems",Replace[vartempkeyword,", ","||"]] AND 
SetAttributeValue["_DEFAULT","_DEFAULT","dummyiteratitems",variterateitems] AND 

ITERATE[variterateitems,
'(IIF[Contains[ITERATIONITEM,varfinalkeyword] = false,
SetVariable["varfinalkeyword",Concat[varfinalkeyword,ITERATIONITEM,", "]]
,false])'
],false] AND 

IIF[varkeywordisempty = "true",
SetVariable["varfinalkeyword",Trim[varfinalkeyword]] AND 
SetVariable["varfinalkeyword",Substring[varfinalkeyword,0,Len[varfinalkeyword]-1]] AND 
SetAttributeValue["_DEFAULT","_DEFAULT","thgkeywords",varfinalkeyword]
,false]