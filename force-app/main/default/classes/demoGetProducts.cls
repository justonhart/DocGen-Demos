/**
 * This class provides data to OmniStudio DocGen. In it, we use SOQL and Apex to build custom data structures to format 
 * our output JSON in whatever way necessary for our desired document template. 
 * The class MUST implement the omnistudio.VlocityOpenInterface2 interface and MUST be declared as global for DocGen to see it.
 * The "call" method should be implemented exactly as follows, and the "invokeMethod" method should call your actual data-gathering logic by passing in the three parameters it receives.
 */
global with sharing class demoGetProducts implements omnistudio.VlocityOpenInterface2 {
    
    /** INTERFACE METHODS
     * the two following methods are required to successfully implement the VlocityOpenInterface2.
     */ 

    global Object call(String action, Map<String, Object> args){
        Map<String, Object> input = (Map<String, Object>)args.get('input');
        Map<String, Object> output = (Map<String, Object>)args.get('output');
        Map<String, Object> options = (Map<String, Object>)args.get('options');
 
        return invokeMethod(action, input, output, options);
    }

    global Object invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options){
        if(methodName == 'getTokenData'){
            getTokenData(input, output, options);
            return true;
        }       
        
        return false;
    }

    /**
     * This method stores the token data expected by the templating engine in the "output" map. This example is incredibly simple: it just queries
     * all existing products for Name and Family, and stores the results in a custom data structure defined below.
     */
    private static void getTokenData(Map<String, Object> input, Map<String, Object> output, Map<String, Object> options) {

        //GATHERING DATA
        
        List<Product2> products = [SELECT Name, Family FROM Product2];
        
        //assembling the custom data structures
        OutputToken out = new OutputToken();
        out.Products = new List<ProductToken>();

        for(Product2 p : products){
            ProductToken pt = new ProductToken();
            pt.Name = p.Name;
            pt.Family = p.Family;
            out.Products.add(pt);
        }
        
        //PREPARING RESULTS FOR DOCGEN
        
        //this is a goofy-looking line but apparently it's necessary - serializing and de-serializing the data structure converts it to a format that DocGen can work with
        output.put('tokenMap',JSON.deserializeUntyped(JSON.serialize(out)));
    }
    
    //DATA STRUCTURES

    /**
     * The custom data structures define here need to match the format that your template expects. The property names need to exactly match the respective tokens in the template, 
     * INCLUDING "IF_" for conditionals. Since this class is written for the "ProductListDemoTemplate" template, 
     * the expected format is as follows:
     * {
     *      Products: [
     *          {
     *              Name: String,
     *              Family: String
     *          }
     *      ]
     * }
     */
    
    private class OutputToken{
        List<ProductToken> Products;
    }
    
    private class ProductToken{
        String Name;
        String Family;
    }
}