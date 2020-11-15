Landlord.destroy_all
Property.destroy_all
Tenant.destroy_all
PropertyTenant.destroy_all

joe = Landlord.create(name: "James G", bio: "A good landlord with cheap houses", image_url: "https://images.unsplash.com/photo-1503443207922-dff7d543fd0e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=882&q=80", email: "james@test.com", password: "123")
jane = Landlord.create(name: "Jane S", bio: "A friendly landlady with big houses", image_url: "https://images.pexels.com/photos/3657429/pexels-photo-3657429.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260", email: "jane@test.com", password: "123")

dulverton = Property.create(address: "123 Dulverton Court", price: "£800pcm", description: "located in central", image_url: "https://assets.themodernhouse.com/wp-content/uploads/2019/12/The-Coach-House-St-Donatts-Road-London-SE14-21-1-1600x1067.jpg", landlord_id: jane.id)
london = Property.create(address: "7 London Road", price: "£1000pcm", description: "big and clean house", image_url: "https://www.idesignarch.com/wp-content/uploads/Hyde-Park-Mews_1-1024x683.jpg", landlord_id: jane.id)
camplin = Property.create(address: "43 Camplin Street", price: "£500pcm", description: "affordable house", image_url: "https://i.pinimg.com/originals/a3/4a/81/a34a81d706ca05ba8646d52de7167212.jpg", landlord_id: joe.id)

peter = Tenant.create(name: "Peter P", profile: "A trustworthy tenant", image_url: "https://lumiere-a.akamaihd.net/v1/images/open-uri20150422-20810-r3neg5_4c4b3ee3.jpeg?region=0,0,600,600&width=320", email: "peter@test.com", password: "123")
wendy = Tenant.create(name: "Wendy D", profile: "A clean tenant", image_url: "https://i.pinimg.com/originals/0b/8f/bf/0b8fbfd4b3b0cf792d2db762af5cc381.jpg", email: "wendy@test.com", password: "123")
hook = Tenant.create(name: "James H", profile: "An annoying tenant", image_url: "https://vignette.wikia.nocookie.net/disney/images/0/0b/Profile_-_Captain_Hook.jpeg/revision/latest?cb=20190312022618", email: "hook@test.com", password: "123")

dulverton_peter = PropertyTenant.create(property_id: dulverton.id, tenant_id: peter.id)
dulverton_wendy = PropertyTenant.create(property_id: dulverton.id, tenant_id: wendy.id)
camplin_hook = PropertyTenant.create(property_id: camplin.id, tenant_id: hook.id)

