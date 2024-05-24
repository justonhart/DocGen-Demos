## DocGen demos

### Demo Document Templates
This repository currently contains two data packs for demo templates in the "Demo Document Templates" folder. You can import them by clicking the "Import" button on the Document Template Designer list. Make sure to activate each template after importing them.

* demoProductListViaDataRaptors - no additional configuration necessary
* demoProductListViaClass - to use this template, you'll have to deploy the demoGetProducts class from this repository.

Once imported, you can test the templates using the sample OmniScript provided with DocGen.

## DocGen Notes & Findings
The DocGen documentation is a nightmare to figure out, so I'm using this section to track my discoveries and questions found while using this product.

### Document Template Designer options
__Token-mapping method__:
* OmniDataTransform - requires both an Extract DR and a Mapping (Transform) DR that maps the output of the Extract to the tokens of the Document Template. 
* Custom Class - custom class must implement the omnistudio.VlocityOpenInterface2 interface. See demoGetProducts.cls for more details.

__Usage Type__
* Doesn't seem to matter

__Document Generation Mechanism__
* Client-side or Server-side doesn't seem to actually make a difference, both client-side and server-side seem to work for my demos regardless of this field