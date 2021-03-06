<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without
Mura CMS under the license of your choice, provided that you follow these specific guidelines:

Your custom code

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->

<cfset subType=application.classExtensionManager.getSubTypeByID(rc.subTypeID)>
<cfset extendSetBean=subType.loadSet(rc.extendSetID) />
<cfoutput>

<div class="mura-header">
	<h1><cfif len(rc.extendSetID)>Edit<cfelse>Add</cfif> Attribute Set</h1>

	<div class="nav-module-specific btn-group">
		<div class="btn-group">
		  <a class="btn dropdown-toggle" data-toggle="dropdown" href="##"><i class="mi-arrow-circle-left"></i> Back <span class="caret"></span></a>
		   <ul class="dropdown-menu">
		      <li><a href="./?muraAction=cExtend.listSubTypes&siteid=#esapiEncode('url',rc.siteid)#">Back to Class Extensions</a></li>
		      <li><a href="./?muraAction=cExtend.listSets&subTypeID=#esapiEncode('url',rc.subTypeID)#&siteid=#esapiEncode('url',rc.siteid)#">Back to Class Extension Overview</a></li>
		   </ul>
		</div>
	</div>

</div> <!-- /.mura-header -->

<div class="block block-constrain">
		<div class="block block-bordered">
		  <div class="block-content">

			<h2><i class="#subtype.getIconClass(includeDefault=true)# mi-lg"></i> #application.classExtensionManager.getTypeAsString(subType.getType())# / #subType.getSubType()#</h2>

			<form novalidate="novalidate" name="form1" method="post" action="index.cfm" onsubit="return validateForm(this);">


			<div class="mura-control-group">
				<label>Attribute Set Name</label>
	<input name="name" type="text" value="#esapiEncode('html_attr',extendSetBean.getName())#" required="true"/>
	</div>

			<cfif subType.getType() neq "Custom">
				<div class="mura-control-group">
					<label>Container (Tab)</label>
			<select name="container">
				<option value="Default">Extended Attributes</option>
				<cfif listFindNoCase('Page,Folder,File,Gallery,Calender,Link,Base',subType.getType())>
					<cfloop list="#application.contentManager.getTabList()#" index="t">
					<cfif t neq 'Extended Attributes' and t neq 'SEO'>
					<option value="#t#"<cfif extendSetBean.getContainer() eq t> selected</cfif>>
					</cfif>
	      			#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.tabs.#REreplace(t, "[^\\\w]", "", "all")#")#
	      			</option>
	      		</cfloop>
	      		<cfelseif listFindNoCase('Component,Form',subType.getType())>
					<cfloop list="Basic,Categorization,Usage Report" index="t">
					<option value="#t#"<cfif extendSetBean.getContainer() eq t> selected</cfif>>
	      			#application.rbFactory.getKeyValue(session.rb,"sitemanager.content.tabs.#REreplace(t, "[^\\\w]", "", "all")#")#
	      			</option>
	      		</cfloop>
	      		<cfelseif subType.getType() neq 'site'>
					<option value="Basic"<cfif extendSetBean.getContainer() eq "Basic"> selected</cfif>>Basic Tab</option>
				</cfif>
				<option value="Custom"<cfif extendSetBean.getContainer() eq "Custom"> selected</cfif>>Custom UI</option>
			</select>
		</div>
			<cfelse>
	<input name="container" value="Custom" type="hidden"/>
			</cfif>

			<!---
			<cfif  not listFindNoCase("1,Site,Custom", subtype.getType()) and application.categoryManager.getCategoryCount(rc.siteID)>
				<div class="mura-control-group">
					<label>Available Category Dependencies</label>
					<div categoryAssignment"><cf_dsp_categories_nest siteID="#rc.siteID#" parentID="" nestLevel="0" extendSetBean="#extendSetBean#">
		</div>
	</div>
			</cfif>
			--->
		<div class="mura-actions">
			<div class="form-actions">
				<cfif not len(rc.extendSetID)>
					<cfset rc.extendSetID=createuuid()>
					<button class="btn mura-primary" type="button" onclick="submitForm(document.forms.form1,'add');"><i class="mi-check-circle"></i>Add</button>
					<input type=hidden name="extendSetID" value="#esapiEncode('html_attr',rc.extendSetID)#">
				<cfelse>
					<button class="btn" type="button" onclick="submitForm(document.forms.form1,'delete','Delete Attribute Set?');"><i class="mi-trash"></i>Delete</button>
					<button class="btn mura-primary" type="button" onclick="submitForm(document.forms.form1,'update');"><i class="mi-check-circle"></i>Update</button>
					<input type=hidden name="extendSetID" value="#esapiEncode('html_attr',extendSetBean.getExtendSetID())#">
				</cfif>
			</div>
		</div>

			<input type="hidden" name="action" value="">
			<input name="muraAction" value="cExtend.updateSet" type="hidden">
			<input name="siteID" value="#esapiEncode('html_attr',rc.siteid)#" type="hidden">
			<input name="subTypeID" value="#esapiEncode('html_attr',subType.getSubTypeID())#" type="hidden">
			#rc.$.renderCSRFTokens(context=rc.extendSetID,format="form")#
			</form>

		</div> <!-- /.block-content -->
	</div> <!-- /.block-bordered -->
</div> <!-- /.block-constrain -->
</cfoutput>
