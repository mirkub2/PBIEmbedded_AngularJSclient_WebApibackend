# PBIEmbedded_AngularJSclient_WebApibackend

I prepared this solution for Asseco Solutions hackfest with focus on PowerBI Embedded. We had to solve, <b>how to use power of PowerBI Embedded visualizations in existing mostly on-premise architecture based on AngularJS</b>. This solution contains only my code snippets and data T-SQL scripts,  which helped to accelerate final partner product.
This solution demonstrates, how to solve these tasks:<br /><br />
1. Securely generate PowerBI Embedded embed token with expiration period 3 minutes on server side<br />
2. Add calls for PowerBI Embedded workspaces metadata to existing AngularJS application with minimal changes<br />
3. Add PowerBI Embedded report rendering to AngularJS application<br />
4. Create simple renderring sesion counter, which will stop unusually frequent report sessions refreshing<br />
5. Create database schema, which will allow use PowerBI Embedded directly against JSON data in tables<br />

