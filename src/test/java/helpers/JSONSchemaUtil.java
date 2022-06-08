package helpers;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.fge.jackson.JsonLoader;
import com.github.fge.jsonschema.core.report.ProcessingReport;
import com.github.fge.jsonschema.main.JsonSchema;
import com.github.fge.jsonschema.main.JsonSchemaFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JSONSchemaUtil {

    private static final Logger logger = LoggerFactory.getLogger(JSONSchemaUtil.class);

    public static boolean isValid(String json, String schema) throws Exception {
        JsonNode schemaNode = JsonLoader.fromString(schema);
        JsonSchemaFactory factory = JsonSchemaFactory.byDefault();
        JsonSchema jsonSchema = factory.getJsonSchema(schemaNode);
        JsonNode jsonNode = JsonLoader.fromString(json);
        System.out.println("=====================================================================");
        System.out.println(jsonNode + " camsjsonNode");
        System.out.println("=====================================================================");
        System.out.println(schemaNode + " camsjsonSchemaNode");
        System.out.println("=====================================================================");
        ProcessingReport report = jsonSchema.validate(jsonNode);
        logger.debug("report: {}", report);
        return report.isSuccess();
    }

}