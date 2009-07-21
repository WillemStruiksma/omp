{**
 * submissionsInEditing.tpl
 *
 * Copyright (c) 2003-2009 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show editor's submissions in editing.
 *
 * $Id$
 *}
<div id="submissions">
<table width="100%" class="listing">
	<tr>
		<td colspan="9" class="headseparator">&nbsp;</td>
	</tr>
	<tr class="heading" valign="bottom">
		<td width="5%">{sort_search key="common.id" sort="id"}</td>
		<td width="5%"><span class="disabled">MM-DD</span><br />{sort_heading key="submissions.submit" sort="submitDate"}</td>
		<td width="5%">{sort_search key="submissions.acquisitionsArrangement" sort="arrangement"}</td>
		<td width="15%">{sort_search key="monograph.authors" sort="authors"}</td>
		<td width="25%">{sort_search key="monograph.title" sort="title"}</td>
		<td width="10%">{sort_search key="submission.copyedit" sort="subCopyedit"}</td>
		<td width="10%">{sort_search key="submission.layout" sort="subLayout"}</td>
		<td width="10%">{sort_search key="submissions.proof" sort="subProof"}</td>
		<td width="5%">{translate key="monograph.sectionEditor"}</td>
	</tr>
	<tr>
		<td colspan="9" class="headseparator">&nbsp;</td>
	</tr>
	
	{iterate from=submissions item=submission}
	{assign var="layoutSignoff" value=$submission->getSignoff('SIGNOFF_LAYOUT')}
	{assign var="layoutEditorProofSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_LAYOUT')}
	{assign var="copyeditorFinalSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
	{assign var="highlightClass" value=$submission->getHighlightClass()}
	{assign var="fastTracked" value=$submission->getFastTracked()}
	<tr valign="top"{if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
		<td>{$submission->getMonographId()}</td>
		<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getAcquisitionsArrangementAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td><a href="{url op="submissionEditing" path=$submission->getMonographId()}" class="action">{$submission->getLocalizedTitle()|strip_unsafe_html|truncate:40:"..."}</a></td>
		<td>{if $copyeditorFinalSignoff->getDateCompleted()}{$copyeditorFinalSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>{if $layoutSignoff->getDateCompleted()}{$layoutSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>{if $layoutEditorProofSignoff->getDateCompleted()}{$layoutEditorProofSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>
			{assign var="editAssignments" value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}{$editAssignment->getEditorInitials()} {/foreach}
		</td>
	</tr>
	<tr>
		<td colspan="9" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="9" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
	<tr>
		<td colspan="9" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td colspan="5" align="left">{page_info iterator=$submissions}</td>
		<td colspan="4" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth section=$section}</td>
	</tr>
{/if}
</table>
</div>
