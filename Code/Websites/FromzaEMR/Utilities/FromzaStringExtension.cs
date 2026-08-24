using System.Text.RegularExpressions;

namespace FromzaEMR.Utilities
{
    public static class FromzaStringExtension
    {
        // Returns boolean value (true/false) 
        public static bool Like(this string searchExpression, string searchKey)
        {
            return new Regex(@"\A" + new Regex(@"\.|\$|\^|\{|\[|\(|\||\)|\*|\+|\?|\\").Replace(searchKey, ch => @"\" + ch).Replace('_', '.').Replace("%", ".*") + @"\z", RegexOptions.Singleline).IsMatch(searchExpression);
        }
    }
}

