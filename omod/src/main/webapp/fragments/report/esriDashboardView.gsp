<style>
textarea {
	border: 1px solid black;
	background: black;
	color: white;
	padding: 10px;
	width: 850px;
	height: 300px;
	overflow: scroll;
	font-size: 12px;
	font-family: Monaco,Andale Mono,Courier New,monospace;
}
	.successText {
		color: dodgerblue;
		font-weight: bold;
		font-size: 18px;
		font-family: Monaco,Andale Mono,Courier New,monospace;
	}

	.errorText {
		color: red;
		font-size: 18px;
		font-weight: bold;
		font-family: Monaco,Andale Mono,Courier New,monospace;
	}
</style>

<div class="ke-page-sidebar">
	<div class="ke-panel-frame">
		${ ui.includeFragment("kenyaui", "widget/panelMenuItem", [ iconProvider: "kenyaui", icon: "buttons/back.png", label: "Back", href: returnUrl ]) }
	</div>
</div>
<div class="ke-page-content">

	<h2>ESRIE Dashboard Payload for ${ reportName }</h2>
	<fieldset>
		<legend>Reporting Date</legend>
		<br/>
		<b>Start Date:</b>	${ startDate } <br/>
		<b>End Date:</b> &nbsp;${ endDate }
	</fieldset>
	<br/>


	<div id="showStatus">
		<span id="msgSpan"></span> &nbsp;&nbsp;<img src="${ ui.resourceLink("kenyaui", "images/loader_small.gif") }"/>
	</div>
	<br/>
	<div id="msg"></div>
	<br/>
	<br/>
	<button id="toggleAdxDiv">Show/Hide Message</button> &nbsp;&nbsp;
	<button id="post">Save Payload</button>
	<p></p>

	<div id="adxMsg">
		<textarea> 	${ adx } </textarea>
	</div>
	<br/>

</div>

<script type="text/javascript">
    jq = jQuery;

    jq(function() {
        jq("#showStatus").hide();
        jq("#adxMsg").hide();
        jq('#post').click(function() {
            jq("#msgSpan").text("Saving report indicators .....");
            jq("#showStatus").show();
            jq("#msg").text("");

            jq("#post").prop("disabled", true);
            jq.getJSON('${ ui.actionLink("saveDashboardPayload") }', {
                'request': '${ reportRequest.id }',
                'returnUrl': '${ returnUrl }'
            })
                .success(function(data) {
                    jq("#showStatus").hide();
                    jq("#msg").addClass("successText");
                    jq("#msg").text("Report indicators successfully saved");
                    jq("#post").prop("disabled", true);
                })
                .error(function(xhr, status, err) {
                    jq("#showStatus").hide();
                    jq("#msg").addClass("errorText");
                    jq("#msg").text("Error saving report indicators: " + xhr.responseText);
                    jq("#post").prop("disabled", false);
                })

        });

        jq('#toggleAdxDiv').click(function() {

            jq("#adxMsg").toggle();
		});

    });
</script>
