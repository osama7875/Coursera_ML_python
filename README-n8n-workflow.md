# n8n Google Sheets Daily Email Summary Workflow

This n8n workflow automatically reads data from a Google Sheet and sends a daily email summary to a Gmail address. It includes both webhook and scheduled triggers for flexible automation.

## 📋 Features

- **Webhook Trigger**: Manual execution via HTTP GET request
- **Scheduled Trigger**: Daily execution at 9 AM (configurable)
- **Google Sheets Integration**: Reads data from any Google Sheet
- **Gmail Integration**: Sends formatted HTML and plain text emails
- **Data Processing**: Automatically generates summary statistics
- **Professional Email Format**: Includes tables, statistics, and sample data

## 🚀 Setup Instructions

### 1. Import the Workflow

1. Open your n8n instance
2. Go to **Workflows** > **Import from File**
3. Select the `n8n-google-sheet-email-workflow.json` file
4. Click **Import**

### 2. Configure Google Sheets Integration

1. **Create Google Sheets OAuth2 Credentials**:
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create a new project or select existing one
   - Enable Google Sheets API
   - Create OAuth2 credentials (Application type: Web application)
   - Add authorized redirect URIs: `http://localhost:5678/rest/oauth2-credential/callback`

2. **Set up n8n Google Sheets Credentials**:
   - In n8n, go to **Credentials** > **Add Credential**
   - Select **Google Sheets OAuth2 API**
   - Enter your Client ID and Client Secret
   - Complete the OAuth flow
   - Name it: `Google Sheets OAuth2 API`

3. **Configure the Google Sheets Node**:
   - Replace `YOUR_GOOGLE_SHEET_ID` with your actual Google Sheet ID
   - Update `sheetName` if different from "Sheet1"
   - Modify `range` if needed (default: A:Z)

### 3. Configure Gmail Integration

1. **Create Gmail OAuth2 Credentials**:
   - In the same Google Cloud Console project
   - Enable Gmail API
   - Use the same OAuth2 credentials or create new ones

2. **Set up n8n Gmail Credentials**:
   - In n8n, go to **Credentials** > **Add Credential**
   - Select **Gmail OAuth2 API**
   - Enter your Client ID and Client Secret
   - Complete the OAuth flow
   - Name it: `Gmail OAuth2 API`

3. **Configure the Gmail Node**:
   - Replace `YOUR_RECIPIENT_EMAIL@gmail.com` with the recipient's email
   - Modify the sender settings if needed

### 4. Configure Webhook Settings

1. **Update Webhook URL**:
   - In the "Call Webhook" node, update the URL to match your n8n instance
   - Default: `http://localhost:5678/webhook/daily-summary`
   - For production: `https://your-domain.com/webhook/daily-summary`

2. **Set up Webhook Security** (Optional):
   - Add authentication to the webhook node
   - Configure IP whitelisting if needed

### 5. Configure Schedule

1. **Modify Cron Expression** (Optional):
   - Current: `0 9 * * *` (9 AM daily)
   - Change to your preferred time
   - Examples:
     - `0 8 * * 1-5` (8 AM weekdays only)
     - `0 18 * * *` (6 PM daily)
     - `0 9 * * 1` (9 AM Mondays only)

## 📊 How It Works

### Workflow Flow:

1. **Trigger**: Either webhook call or scheduled trigger
2. **Data Reading**: Connects to Google Sheets and reads all data
3. **Processing**: JavaScript code processes the data to create:
   - Summary statistics
   - Column information
   - Sample data preview
4. **Email Generation**: Creates both HTML and plain text email content
5. **Email Sending**: Sends the email via Gmail
6. **Response**: Returns success confirmation

### Email Content Includes:

- **Summary Statistics**: Total records, columns, last updated
- **Column Names**: List of all column headers
- **Sample Data**: First 5 rows in a formatted table
- **Professional Styling**: Clean HTML formatting with CSS

## 🔧 Customization Options

### Modify Email Content

Edit the JavaScript code in the "Process Data" node to:
- Change summary calculations
- Add custom metrics
- Modify email styling
- Include/exclude specific columns
- Add data validation

### Add Error Handling

Add error handling nodes to:
- Catch Google Sheets API errors
- Handle Gmail sending failures
- Log errors for debugging
- Send error notifications

### Additional Features

You can extend the workflow by adding:
- **Data Filtering**: Filter data before processing
- **Multiple Recipients**: Send to multiple email addresses
- **Attachments**: Export data as CSV/Excel attachments
- **Conditional Logic**: Send emails only when certain conditions are met
- **Slack Integration**: Also send notifications to Slack
- **Data Storage**: Store processed data in a database

## 🛠️ Troubleshooting

### Common Issues:

1. **Google Sheets Access Denied**:
   - Verify OAuth2 credentials are correct
   - Check that the Google Sheet is accessible
   - Ensure the sheet ID is correct

2. **Gmail Authentication Error**:
   - Re-authenticate Gmail OAuth2 credentials
   - Check if Gmail API is enabled
   - Verify OAuth2 scopes include Gmail sending

3. **Webhook Not Responding**:
   - Check if n8n is running and accessible
   - Verify webhook URL is correct
   - Check firewall settings

4. **Email Not Sending**:
   - Verify recipient email address
   - Check Gmail API quotas
   - Review error logs in n8n

### Debug Tips:

- Use "Execute Node" to test individual nodes
- Check the "Executions" tab for error details
- Enable debug mode for detailed logging
- Test webhook manually using curl or browser

## 📝 Example Usage

### Manual Trigger via Webhook:
```bash
curl -X GET "http://localhost:5678/webhook/daily-summary"
```

### Expected Response:
```json
{
  "status": "success",
  "message": "Daily summary email sent successfully",
  "timestamp": "2024-01-01T14:30:00.000Z",
  "recordsProcessed": 150
}
```

## 🔒 Security Considerations

- Use HTTPS in production
- Secure your OAuth2 credentials
- Consider webhook authentication
- Regularly rotate API keys
- Monitor access logs
- Use environment variables for sensitive data

## 📈 Performance Tips

- Limit data range in Google Sheets if dealing with large datasets
- Use pagination for very large sheets
- Consider caching for frequently accessed data
- Monitor API quotas and usage

## 🆘 Support

For issues and questions:
- Check n8n documentation: https://docs.n8n.io/
- Google Sheets API docs: https://developers.google.com/sheets/api
- Gmail API docs: https://developers.google.com/gmail/api

## 📄 License

This workflow is provided as-is for educational and commercial use. Modify and adapt according to your needs.