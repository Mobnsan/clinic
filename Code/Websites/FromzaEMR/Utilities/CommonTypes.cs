/*
 File: CommonTypes.cs
 created: 28Jan'17-sudarshan
 description: this class contains all type classes which are to be used commonly across the appliccation
 remarks: 
 -------------------------------------------------------------------
 change history:
 -------------------------------------------------------------------
 S.No     ModifiedBy/Date             description           remarks
 -------------------------------------------------------------------
 1.       sudarshan/28Jan'17          created           -- added public class FromzaHTTPResponse<T>

 -------------------------------------------------------------------
 */


namespace FromzaEMR.CommonTypes
{
    public class FromzaHTTPResponse<T>
    {
        public T Results { get; set; }
        public string Status { get; set; }
        public string ErrorMessage { get; set; }

        public FromzaHTTPResponse()
        {
            this.Status = string.Empty;
            this.ErrorMessage = string.Empty;
        }

        public static FromzaHTTPResponse<T> FormatResult(T results)
        {
            return new FromzaHTTPResponse<T>() { Results = results };
        }

        public static FromzaHTTPResponse<T> FormatResult(T results, string status)
        {
            return new FromzaHTTPResponse<T>() { Status = status, Results = results };
        }

        public static FromzaHTTPResponse<T> FormatResult(T results, string status, string errorMessage)
        {
            return new FromzaHTTPResponse<T>() { Status = status, Results = results, ErrorMessage = errorMessage };
        }

    }
}

