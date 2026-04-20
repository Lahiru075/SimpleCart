import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
 
                    Container(
                      decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[200]!, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // User Name
                    const Text(
                      "Lahiru Lakshan",
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.w800, 
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // User Email
                    Text(
                      "lahiru.lakshan@email.com",
                      style: TextStyle(
                        fontSize: 14, 
                        color: Colors.grey[500], 
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account Settings",
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    _buildMenuItem(Icons.person_outline, "My Profile", () {}),
                    _buildMenuItem(Icons.shopping_bag_outlined, "Order History", () {}),
                    _buildMenuItem(Icons.payment_outlined, "Payment Methods", () {}),
                    _buildMenuItem(Icons.help_outline, "Help & Support", () {}),
                    _buildMenuItem(Icons.notifications_none, "Notifications", () {}),
                    
                    const SizedBox(height: 30),
                    
                    GestureDetector(
                      onTap: () {
                      
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red[100]!),
                        ),
                        child: const Center(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.redAccent, 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03), 
            blurRadius: 15, 
            offset: const Offset(0, 5)
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.black, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15, 
            fontWeight: FontWeight.w500, 
            color: Color(0xFF1A1A1A),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}