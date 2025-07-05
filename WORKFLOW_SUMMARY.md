# n8n Google Sheets to Gmail Workflow - Complete Package

## 📦 What You Have

I've created a complete n8n workflow package that reads data from Google Sheets and sends daily email summaries via Gmail. Here's what's included:

### 📄 Files Created

1. **`n8n-google-sheet-email-workflow.json`** - The main workflow file
2. **`README-n8n-workflow.md`** - Detailed setup and configuration guide
3. **`n8n-env-sample.env`** - Environment configuration template
4. **`setup-n8n.sh`** - Automated setup script
5. **`WORKFLOW_SUMMARY.md`** - This summary file

## 🔧 Workflow Components

### Core Nodes:
- **Webhook Trigger** - Accepts HTTP GET requests to `/webhook/daily-summary`
- **Schedule Trigger** - Runs daily at 9 AM (configurable)
- **Google Sheets Node** - Reads data from your Google Sheet
- **Code Node** - Processes data and creates email content
- **Gmail Node** - Sends HTML and plain text emails
- **Response Node** - Returns execution status

### Features:
- ✅ **Dual Triggers**: Manual webhook + daily schedule
- ✅ **Data Processing**: Automatic summary statistics
- ✅ **Professional Emails**: HTML formatting with tables
- ✅ **Error Handling**: Status checking and responses
- ✅ **Configurable**: Easy to customize and extend

## 🚀 Quick Start

### Option 1: Automated Setup
```bash
# Make the script executable (if not already)
chmod +x setup-n8n.sh

# Run the setup script
./setup-n8n.sh
```

### Option 2: Manual Setup
1. Install n8n: `npm install -g n8n`
2. Import workflow: Use `n8n-google-sheet-email-workflow.json`
3. Configure credentials (Google OAuth)
4. Update sheet ID and email addresses
5. Test and activate

## 📋 Configuration Required

### Google Cloud Console Setup:
1. Create a new project or select existing
2. Enable Google Sheets API
3. Enable Gmail API
4. Create OAuth2 credentials
5. Add redirect URI: `http://localhost:5678/rest/oauth2-credential/callback`

### Workflow Configuration:
- Replace `YOUR_GOOGLE_SHEET_ID` with your actual sheet ID
- Replace `YOUR_RECIPIENT_EMAIL@gmail.com` with recipient email
- Update sheet name and range if needed
- Configure schedule (default: daily at 9 AM)

## 🔗 How It Works

### Manual Execution:
```bash
# Trigger via webhook
curl -X GET "http://localhost:5678/webhook/daily-summary"
```

### Automatic Execution:
- Runs daily at 9 AM (configurable)
- Calls the webhook internally
- Processes data and sends email

### Data Flow:
1. **Trigger** → 2. **Read Sheet** → 3. **Process Data** → 4. **Send Email** → 5. **Return Status**

## 📧 Email Content

The generated email includes:
- **Summary Statistics**: Total records, columns, last updated
- **Column Names**: List of all headers
- **Sample Data**: First 5 rows in a table format
- **Professional Styling**: Clean HTML with CSS

### Sample Email Subject:
```
Daily Sheet Summary - 150 records (01/15/2024)
```

## 🎯 Use Cases

- **Daily Reports**: Automated business reports
- **Data Monitoring**: Track sheet changes over time
- **Team Updates**: Share data summaries with team
- **Quality Assurance**: Monitor data completeness
- **Compliance**: Regular data status reports

## 🛠️ Customization Examples

### Change Email Frequency:
```javascript
// Weekly on Mondays at 9 AM
"expression": "0 9 * * 1"

// Weekdays only at 8 AM
"expression": "0 8 * * 1-5"

// Every 6 hours
"expression": "0 */6 * * *"
```

### Add Custom Metrics:
```javascript
// In the Process Data node, add:
const avgValue = dataRows.reduce((sum, row) => sum + parseFloat(row[1] || 0), 0) / dataRows.length;
const maxValue = Math.max(...dataRows.map(row => parseFloat(row[1] || 0)));
```

### Multiple Recipients:
```javascript
// Configure in Gmail node:
"ccList": "team@company.com,manager@company.com"
```

## 📊 Monitoring & Maintenance

### Health Checks:
- Monitor webhook response times
- Check email delivery status
- Review execution logs
- Monitor API quotas

### Regular Tasks:
- Update OAuth tokens when expired
- Review and update recipient lists
- Check for Google API changes
- Monitor workflow execution success rate

## 🔐 Security Best Practices

- Use HTTPS in production
- Secure OAuth credentials
- Enable webhook authentication
- Regular credential rotation
- Monitor access logs
- Use environment variables for secrets

## 🆘 Troubleshooting

### Common Issues:
1. **"Sheet not found"** - Check sheet ID and permissions
2. **"OAuth error"** - Re-authenticate credentials
3. **"Email not sent"** - Check Gmail API limits
4. **"Webhook timeout"** - Check n8n server status

### Debug Steps:
1. Test individual nodes
2. Check execution logs
3. Verify credentials
4. Test with sample data
5. Monitor API responses

## 📈 Performance Optimization

- Limit sheet range for large datasets
- Use data pagination for huge sheets
- Cache frequently accessed data
- Optimize email template size
- Monitor memory usage

## 🎉 Success Metrics

Track these to measure success:
- Email delivery rate
- Workflow execution success rate
- Data processing time
- User engagement with emails
- System uptime

## 📞 Support Resources

- **n8n Documentation**: https://docs.n8n.io/
- **Google Sheets API**: https://developers.google.com/sheets/api
- **Gmail API**: https://developers.google.com/gmail/api
- **OAuth2 Setup**: https://console.cloud.google.com/

## 🎯 Next Steps

1. **Test Setup**: Run the setup script or manual setup
2. **Configure Credentials**: Set up Google OAuth
3. **Import Workflow**: Load the JSON file into n8n
4. **Test Manually**: Use the webhook to test
5. **Enable Schedule**: Activate daily automation
6. **Monitor**: Check logs and email delivery

---

**Happy Automating! 🚀**

This workflow will save you time by automatically summarizing your Google Sheets data and delivering it to your inbox every day. Customize it to fit your specific needs and expand it with additional features as required.