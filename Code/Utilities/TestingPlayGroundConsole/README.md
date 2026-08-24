## Project/File: FromzaEMR.TestingPlayGroundConsole
### Created: 20Jan'23/Sud/Krishna
### Description: 
   * Why:  Since, Implementing  the actual Unit Testing frameworks (eg: NUnit, XUnit) is not feasible in 
            FromzaEMR(Classic) for timebeing. 
         We needed some library to achieve the UnitTesting of calculation & other functions with realistic test data.
   * What:
      *  This library contains Testing classes where we can Add the Actual functions from Different Modules.
       Also we can create Mock-Data and test different scenarios.
       After successfully testing in here, we can simply Copy-Paste that function into Actual impelementation (FromzaEMR libraries).

      * We're referring the FromzaEMR.ServerModels so that we can create mock data using our Actual Models.
      *  This is a Console APP, so it can run independent and is very very lightweight than the FromzaEMR (WebProject) itself.

   * How:
     * TestClasses: TestClasses contains the actual Testing Logic to test any Logic or Functions of FromzaEMR recreating 
                 those functions as TestFunctions.
     * TestFunctions: TestFunctions will contain the actual Logic from the FromzaEMR libraries.s
     * MockDataProviders: MockDataProviders contains actual test data referring FromzaEMR.ServerModel which provides test data to * TestFunctions
     * TestRunner:  Main Function (in Program.cs) can be used to run the Tests in All TestClasses
     
     * Example of Folder Structure:

        ```
        â”œâ”€â”€ Modules
        â”‚   â”œâ”€â”€ ADT
        â”‚   â”‚   â”œâ”€â”€ TestClasses
        â”‚   â”‚   â”œâ”€â”€ Models
        â”‚   â”‚   â”œâ”€â”€ MockDataProviders

        ```

<span style="color:red;font-weight:bold;"> Note: </span> 
<span style="color:blue"> This framework doesn't give Pass/Fail status. Rather we have to check manually by running the required functions.</span>     
