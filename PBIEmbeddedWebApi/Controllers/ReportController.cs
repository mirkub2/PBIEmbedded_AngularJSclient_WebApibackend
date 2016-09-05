using Microsoft.PowerBI.Api.V1;
using Microsoft.PowerBI.Api.V1.Models;
using Microsoft.PowerBI.Security;
using Microsoft.Rest;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Http;
//using System.Web.Mvc;

namespace PBIEmbeddedWebApi.Controllers
{
    public class ReportController : ApiController
    {

        public static int ClientPageLoadCounter = 0;
        private readonly string workspaceCollection;
        private readonly string workspaceId;
        private readonly string accessKey;
        private readonly string apiUrl;

        public ReportController()
        {
            this.workspaceCollection = ConfigurationManager.AppSettings["powerbi:WorkspaceCollection"];
            this.workspaceId = ConfigurationManager.AppSettings["powerbi:WorkspaceId"];
            this.accessKey = ConfigurationManager.AppSettings["powerbi:AccessKey"];
            this.apiUrl = ConfigurationManager.AppSettings["powerbi:ApiUrl"];
        }

        // GET api/report
        public List<Report> GetAllReports() //get method
        {
            using (var client = this.CreatePowerBIClient())
            {
                var reportsResponse = client.Reports.GetReports(this.workspaceCollection, this.workspaceId);
               return reportsResponse.Value.ToList<Report>();
            }
            //Instedd of static variable you can use database resource to get the data and return to API
        }

        public string GetReportById(string rid) {
            using (var client = this.CreatePowerBIClient())
            {
                var embedToken = PowerBIToken.CreateReportEmbedToken(this.workspaceCollection, this.workspaceId, rid);
                embedToken.Expiration = DateTime.Now.AddMinutes(3);
                try
                {
                    return embedToken.Generate(this.accessKey);
                }
                catch
                { return ""; };
            }
        }

        public string GetReportByIdUsername(string rid, string username)
        {
            string[] roles = new string[] { "" };
            using (var client = this.CreatePowerBIClient())
            {
                var embedToken = PowerBIToken.CreateReportEmbedToken(this.workspaceCollection, this.workspaceId, rid, username, roles);
                embedToken.Expiration = DateTime.Now.AddMinutes(3);
                try
                {
                    return embedToken.Generate(this.accessKey);
                }
                catch
                { return ""; };
            }
        }

        public string GetReportByIdUsernameRoles(string rid, string username, string roles)
        {
            var array_roles = roles.Split('~'); 
            using (var client = this.CreatePowerBIClient())
            {
                var embedToken = PowerBIToken.CreateReportEmbedToken(this.workspaceCollection, this.workspaceId, rid, username, array_roles);
                embedToken.Expiration = DateTime.Now.AddMinutes(3);
                try
                {
                    return embedToken.Generate(this.accessKey);
                }
                catch
                { return ""; };
            }
        }

        // GET api/report/1
        //[Route("{rid:string}/{username:string}/{roles:string[]}")]
        public IHttpActionResult GetReport(string rid,string username, string[] roles)
        {
            using (var client = this.CreatePowerBIClient())
            {
                var embedToken = PowerBIToken.CreateReportEmbedToken(this.workspaceCollection, this.workspaceId, rid, username, roles);
                embedToken.Expiration = DateTime.Now.AddMinutes(3);
                try
                {
                    return Ok(embedToken.Generate(this.accessKey));
                }
                catch
                { return NotFound(); };
            }
        }

        private IPowerBIClient CreatePowerBIClient()
        {
            var credentials = new TokenCredentials(accessKey, "AppKey");
            var client = new PowerBIClient(credentials)
            {
                BaseUri = new Uri(apiUrl)
            };


            return client;
        }

    }
}
