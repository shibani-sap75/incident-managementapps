using ProcessorService as service from '../../srv/service';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Customer}',
                Value : customer_ID,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Overview',
            ID : 'Overview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    ID : 'GeneratedFacet1',
                    Label : '{i18n>GeneralInformation}',
                    Target : '@UI.FieldGroup#GeneratedGroup',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Details',
                    ID : 'Details',
                    Target : '@UI.FieldGroup#Details',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Conversation',
                    ID : 'Conversation',
                    Target : 'conversation/@UI.LineItem#Conversation',
                },
            ],
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Customer',
            Value : customer_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : 'Name',
        },
        {
            $Type : 'UI.DataField',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.code,
            Label : '{i18n>Urgency}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Status}',
            Value : status_code,
            Criticality : status.criticality,
            CriticalityRepresentation : #WithIcon,
        },
        {
            $Type : 'UI.DataField',
            Value : customer.createdAt,
        },
        {
            $Type : 'UI.DataField',
            Value : customer.createdBy,
        },
    ],
    UI.SelectionFields : [
        status_code,
        urgency.descr,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer.name,
        },
        TypeImageUrl : 'sapicon://alert',
    },
    UI.FieldGroup #Details : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : '{i18n>Status}',
                Criticality : status.criticality,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },
        ],
    },
);

annotate service.Incidents with {
    customer @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customer',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.Text : customer.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Incidents with {
    status @(
        Common.Label : '{i18n>StatusCode}',
        Common.ValueListWithFixedValues : true,
        Common.Text : status.descr,
    )
};

annotate service.Incidents with {
    urgency @(
        Common.Label : '{i18n>Urgency}',
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Urgency',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : urgency_code,
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.Text : urgency.descr,
        Common.Text.@UI.TextArrangement : #TextOnly,
        )
};

annotate service.Urgency with {
    descr @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextLast,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Urgency',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : descr,
                    ValueListProperty : 'descr',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Label : '{i18n>Urgency}',
)};

annotate service.Urgency with {
    name @(
        Common.Text : descr,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.Status with {
    name @(
        Common.Text : descr,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.Urgency with {
    code @(
        Common.Text : descr,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.Status with {
    code @Common.Text : descr
};

annotate service.Incidents.conversation with @(
    UI.LineItem #Conversation : [
        {
            $Type : 'UI.DataField',
            Value : up_.conversation.author,
            Label : '{i18n>Author}',
        },
        {
            $Type : 'UI.DataField',
            Value : up_.conversation.message,
            Label : '{i18n>Message}',
        },
        {
            $Type : 'UI.DataField',
            Value : up_.conversation.timestamp,
            Label : '{i18n>Date}',
        },
    ]
);

